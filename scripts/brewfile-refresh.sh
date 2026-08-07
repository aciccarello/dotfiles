#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

CONFIG_REL="brewfile-annotations.yaml"
EXPORT_FILE="/tmp/Brewfile.export"

if [[ $# -ne 0 ]]; then
	echo "This script does not accept options. It always updates Brewfile in place." >&2
	exit 2
fi

if ! command -v brew >/dev/null 2>&1; then
	echo "brew is required but not found in PATH." >&2
	exit 2
fi

if ! command -v yq >/dev/null 2>&1; then
	echo "yq is required for brewfile refresh annotations." >&2
	echo "Install it with: brew install yq" >&2
	exit 2
fi

CONFIG_PATH="${REPO_ROOT}/${CONFIG_REL}"
BREWFILE_PATH="${REPO_ROOT}/Brewfile"

if [[ ! -f "${CONFIG_PATH}" ]]; then
	echo "Missing config file: ${CONFIG_PATH}" >&2
	exit 2
fi

echo "Loading current Brewfile bundle dump..."
brew bundle dump --force --file "${EXPORT_FILE}" >/dev/null

echo "Updating Brewfile based on annotations from: ${CONFIG_PATH}"

optional_behavior="$(yq -r '.settings.optional_behavior // "comment_out"' "${CONFIG_PATH}")"
append_missing="$(yq -r '.settings.append_missing_optional_or_excluded // true' "${CONFIG_PATH}")"
normalize_vscode_ids="$(yq -r '.settings.normalize_vscode_ids // true' "${CONFIG_PATH}")"

tmp_output="$(mktemp)"
tmp_seen="$(mktemp)"
pending_comments=""

cleanup() {
	rm -f "${tmp_output}" "${tmp_seen}"
}
trap cleanup EXIT

canonical_key() {
	local line="$1"
	if [[ "${line}" =~ ^(tap|brew|cask|mas|vscode)[[:space:]]+\"([^\"]+)\"(.*)$ ]]; then
		local kind="${BASH_REMATCH[1]}"
		local name="${BASH_REMATCH[2]}"
		local rest="${BASH_REMATCH[3]}"

		if [[ "${kind}" == "vscode" && "${normalize_vscode_ids}" == "true" ]]; then
			name="$(printf '%s' "${name}" | tr '[:upper:]' '[:lower:]')"
		fi

		if [[ "${kind}" == "mas" && "${rest}" =~ id:[[:space:]]*([0-9]+) ]]; then
			printf '%s "%s", id: %s\n' "${kind}" "${name}" "${BASH_REMATCH[1]}"
			return 0
		fi

		printf '%s "%s"\n' "${kind}" "${name}"
		return 0
	fi

	return 1
}

flush_pending_comments() {
	if [[ -n "${pending_comments}" ]]; then
		printf '%s' "#${pending_comments}" >> "${tmp_output}"
		pending_comments=""
	fi
}

discard_pending_comments() {
	pending_comments=""
}

render_entry() {
	local line="$1"
	local optional="$2"
	local excluded="$3"
	local comment="$4"
	local output_line="${line}"

	if [[ "${excluded}" == "true" ]]; then
			# Excluded entries are intentionally omitted from output.
		return 0
	fi

	if [[ "${optional}" == "true" && "${optional_behavior}" == "comment_out" ]]; then
		if [[ -n "${comment}" ]]; then
			printf '# %s # optional: %s\n' "${line}" "${comment}"
		else
			printf '# %s # optional\n' "${line}"
		fi
		return 0
	fi

	if [[ -n "${comment}" ]]; then
		if [[ "${line}" != *"#"* ]]; then
			if [[ "${optional}" == "true" ]]; then
				output_line="${line} # optional: ${comment}"
			else
				output_line="${line} # ${comment}"
			fi
		fi
	fi

	printf '%s\n' "${output_line}"
}

while IFS= read -r line; do
	if [[ "${line}" =~ ^# ]]; then
		pending_comments+="${line}"$'\n'
		continue
	fi

	if [[ -z "${line}" ]]; then
		# Keep spacing tidy and avoid carrying comments across unrelated entries.
		discard_pending_comments
		printf '\n' >> "${tmp_output}"
		continue
	fi

	if ! key="$(canonical_key "${line}")"; then
		flush_pending_comments
		printf '%s\n' "${line}" >> "${tmp_output}"
		continue
	fi

	printf '%s\n' "${key}" >> "${tmp_seen}"

	if [[ "${normalize_vscode_ids}" == "true" && "${key}" =~ ^vscode[[:space:]]+\"([^\"]+)\"$ ]]; then
		lower_id="$(printf '%s' "${BASH_REMATCH[1]}" | tr '[:upper:]' '[:lower:]')"
		if [[ "${lower_id}" != "${BASH_REMATCH[1]}" ]]; then
			line="vscode \"${lower_id}\""
		fi
	fi

	exists="$(KEY="${key}" yq -r '.entries[strenv(KEY)] != null' "${CONFIG_PATH}")"
	if [[ "${exists}" != "true" ]]; then
		flush_pending_comments
		printf '%s\n' "${line}" >> "${tmp_output}"
		continue
	fi

	optional="$(KEY="${key}" yq -r '.entries[strenv(KEY)].optional // false' "${CONFIG_PATH}")"
	excluded="$(KEY="${key}" yq -r '.entries[strenv(KEY)].excluded // false' "${CONFIG_PATH}")"
	comment="$(KEY="${key}" yq -r '.entries[strenv(KEY)].comment // ""' "${CONFIG_PATH}")"

	rendered_line="$(render_entry "${line}" "${optional}" "${excluded}" "${comment}")"
	if [[ -n "${rendered_line}" ]]; then
		flush_pending_comments
		printf '%s\n' "${rendered_line}" >> "${tmp_output}"
	else
		# Entry was excluded, so drop any preceding descriptive comments.
		discard_pending_comments
	fi
done < "${EXPORT_FILE}"

# If dump ends with comment lines not tied to an entry, keep them.
flush_pending_comments

if [[ "${append_missing}" == "true" ]]; then
	added_header=false

	while IFS= read -r raw_key; do
		if [[ -z "${raw_key}" ]]; then
			continue
		fi

		if ! key="$(canonical_key "${raw_key}")"; then
			key="${raw_key}"
		fi

		if grep -Fxq "${key}" "${tmp_seen}"; then
			continue
		fi

		optional="$(KEY="${key}" yq -r '.entries[strenv(KEY)].optional // false' "${CONFIG_PATH}")"
		excluded="$(KEY="${key}" yq -r '.entries[strenv(KEY)].excluded // false' "${CONFIG_PATH}")"

		if [[ "${excluded}" == "true" ]]; then
			continue
		fi

		if [[ "${optional}" != "true" ]]; then
			continue
		fi

		comment="$(KEY="${key}" yq -r '.entries[strenv(KEY)].comment // ""' "${CONFIG_PATH}")"

		if [[ "${added_header}" == "false" ]]; then
			printf '\n## Added from annotations (missing in local export)\n' >> "${tmp_output}"
			added_header=true
		fi

		render_entry "${key}" "${optional}" "${excluded}" "${comment}" >> "${tmp_output}"
	done < <(yq -r '.entries | keys | .[]' "${CONFIG_PATH}")
fi

changes_detected=false
if ! cmp -s "${BREWFILE_PATH}" "${tmp_output}"; then
	changes_detected=true
fi

cp "${tmp_output}" "${BREWFILE_PATH}"

echo "Export file: ${EXPORT_FILE}"
echo "Config file: ${CONFIG_PATH}"
echo "Output file: ${BREWFILE_PATH}"

if [[ "${changes_detected}" == "true" ]]; then
	echo "Brewfile updated. Review changes with: git --no-pager diff -- Brewfile"
else
	echo "No Brewfile changes were needed."
fi
