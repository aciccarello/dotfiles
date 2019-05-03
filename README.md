# dotfiles
Herein lies my dotfile config

Managed via [Dotbot](https://github.com/anishathalye/dotbot/)

# Applying dotfiles
**Warning: This will override your existing settings**
```bash
./install
```

## Updating
In general, you should be using symbolic links for everything, and using git submodules whenever possible.

To keep submodules at their proper versions, you could include something like git submodule update --init --recursive in your install.conf.yaml.

To upgrade your submodules to their latest versions, you could periodically run git submodule update --init --remote.

## Modifying script permissions
To allow running a script, use the following `chmod` commmand with the path to the script file.

```bash
chmod +x ./path-to-script.sh
```

## Updating vscode extesion list
Currently the vscode extension list is readonly. To update the `extensions.txt` file run the following command
```bash
code --list-extensions > ~/.dotfiles/vscode/extentions.txt
```

## Additional Software
This software should be installed manually.
* [VS Code](https://code.visualstudio.com/Download)
* [Microsoft Erogonomic Mouse](https://www.microsoft.com/accessories/en-id/d/natural-ergonomic-keyboard-4000)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [Logitech Unifying Software](https://support.logitech.com/en_us/software/unifying)

## Finding defaults from menus
Print the defaults to two files before and after the change and compare the two files.
```bash
defaults read com.apple.dock > defaults.txt
```
