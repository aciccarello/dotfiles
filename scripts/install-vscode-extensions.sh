#!/usr/bin/env bash

while read line; do
	# As of 2023-05-10 Electron was throwing Buffer() deprecation warning
    NODE_OPTIONS=--throw-deprecation code --install-extension $line
done < ./vscode/extensions.txt

echo "Installation complete"
