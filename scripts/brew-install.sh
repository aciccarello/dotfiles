if ! command -v brew &> /dev/null
then
	command -v brew >/dev/null 2>&1 || {/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"}
	(echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> ~/.zprofile
	eval "$(/usr/local/bin/brew shellenv)"
else
	echo "Brew already installed"
fi
