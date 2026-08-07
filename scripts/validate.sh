#!/usr/bin/env bash

set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

info() {
	printf '[INFO] %s\n' "$1"
}

pass() {
	printf '[PASS] %s\n' "$1"
}

fail() {
	printf '[FAIL] %s\n' "$1" >&2
	exit 1
}

run_check() {
	local label="$1"
	shift

	info "${label}"
	if "$@"; then
		pass "${label}"
	else
		fail "${label}"
	fi
}

validate_yaml() {
	cd "${BASEDIR}"
	ruby -e 'require "yaml"; YAML.safe_load(File.read("install.conf.yaml"), aliases: true)'
}

validate_json_file() {
	local path="$1"
	python3 -c 'import json, sys; json.load(open(sys.argv[1], "r", encoding="utf-8"))' "$path"
}

validate_jsonc_file() {
	local path="$1"
	if ! command -v node >/dev/null 2>&1; then
		echo "node is required to parse VS Code JSONC files" >&2
		return 1
	fi

	node -e '
const fs = require("fs");
const vm = require("vm");
const file = process.argv[1];
const input = fs.readFileSync(file, "utf8");
vm.runInNewContext("(" + input + ")", {}, { filename: file });
' "$path"
}

validate_shell_syntax() {
	cd "${BASEDIR}"
	bash -n install
	while IFS= read -r -d '' script_path; do
		bash -n "${script_path}"
	done < <(find scripts -type f -name '*.sh' -print0)
}

validate_dotbot_dry_run() {
	cd "${BASEDIR}"
	./dotbot/bin/dotbot \
		-d "${BASEDIR}" \
		--plugin-dir "${BASEDIR}/dotbot-brewfile" \
		-c "install.conf.yaml" \
		--dry-run \
		--exit-on-failure
}

validate_brew_bundle() {
	cd "${BASEDIR}"
	brew bundle check --file Brewfile
}

run_check "YAML parse: install.conf.yaml" validate_yaml
run_check "JSONC parse: vscode/settings.json" validate_jsonc_file "${BASEDIR}/vscode/settings.json"
run_check "JSONC parse: vscode/keybindings.json" validate_jsonc_file "${BASEDIR}/vscode/keybindings.json"
run_check "JSON parse: RectangleConfig.json" validate_json_file "${BASEDIR}/RectangleConfig.json"
run_check "Shell syntax: install + scripts/*.sh" validate_shell_syntax
run_check "Dotbot dry-run" validate_dotbot_dry_run
run_check "Homebrew bundle check" validate_brew_bundle

printf '\nValidation completed successfully.\n'
