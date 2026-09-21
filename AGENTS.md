# Global AI Instructions

These instructions apply across all projects unless overridden by a project-level AGENTS.md.

## Coding Style

- Follow the conventions already present in the file or project being edited.
- Prefer small, focused functions with a single responsibility.
- Use descriptive variable and function names; avoid abbreviations unless they are universally understood in context.
- Avoid overly verbose comments, write code clearly so comments mainly explain "why" not "how".
- Remove dead code rather than commenting it out.
- For long-lived projects, consider additional code a liability. Prefer less code
- Prefer explicit over implicit: clear error messages, clear types, clear intent.
- When adding dependencies, prefer well-maintained packages with minimal footprint.
- Write unit tests that test outcomes (not implementation)
- Run unit tests and lint/format code before considering code finished
- Make sure the current branh is updated from the primary branch (usually main or master) before starting analysis or code changes to avoid later conflicts

## Tone and Communication

- Be concise. Prefer short answers unless depth is explicitly needed.
- Do not use filler phrases ("Certainly!", "Great question!", "Of course!").
- When something is uncertain, say so. Don't invent answers.
- Prefer bullet lists and code blocks over long prose.
- If a task is ambiguous, ask one clarifying question before proceeding.
- If there is a clear, better alternative to a command, ask if that approach should be used instead

## Tool and Permission Defaults

- Always read a file before editing it.
- Prefer targeted edits over full rewrites.
- Do not run destructive shell commands (rm -rf, drop table, etc.) without explicit confirmation.
- Do not commit, push, or open PRs unless explicitly asked.
- Do not commit spec or design files (e.g. as created by the superpowers plugin) unless asked to do so
- Do not install packages or change lock files without asking first.
- Use existing project tooling (linters, formatters, test runners) when available.

## Project-Agnostic Rules

- Do not add comments that merely restate the code.
- Do not create new files unless they are necessary to complete the task.
- Do not silently change behavior outside the scope of the request.
- When fixing a bug, also note if the same pattern exists elsewhere but do not auto-fix it.
- Prefer fixing root causes over patching symptoms.
- Keep diffs minimal and reviewable.

## Project Context

- See project README.md files for project overview
- Avoid creating separate AI focused documentation, documentation should be written for humans too

## CLI tools to consider using

- zsh is the default shell
- `gh` for github
- `nvm` for managing node versions
- 'uv' for managing python
- `jq` for parsing json
- `yq` for parsing yaml
