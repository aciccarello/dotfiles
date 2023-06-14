if ! command -v brew &> /dev/null
then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	
	echo "Brew installed. See 'Next steps' for further instructions"
	echo "NOTE: Brewfile cannot be read till next steps are completed"
	exit 1
else
	echo "Brew already installed"
fi
