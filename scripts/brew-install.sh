#!/usr/bin/env bash

set -euo pipefail

if ! command -v brew &> /dev/null
then
	if ! command -v curl >/dev/null 2>&1; then
		echo "curl is required to install Homebrew" >&2
		exit 2
	fi

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	
	echo "Brew installed. See 'Next steps' for further instructions"
	echo "NOTE: Brewfile cannot be read till next steps are completed"
	exit 1
else
	echo "Brew already installed"
fi
