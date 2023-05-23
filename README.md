# dotfiles

Herein lies my dotfile config

Managed via [Dotbot](https://github.com/anishathalye/dotbot/)

# Applying dotfiles

**Warning: This will override your existing settings**

```bash
./install
```

## Manual Config

### Modifier Keys

Windows keyboards will need the Command and Option keys switched.
Additionally, I like to map the Caps Lock to Control for easier keyboard shortcuts.

> System Preferences > Keyboard > Modifier Keys

TODO: Figure out if this can be scripted.
[Stack Exchange](https://apple.stackexchange.com/questions/13598/updating-modifier-key-mappings-through-defaults-command-tool)
[StackExchange 2](https://apple.stackexchange.com/questions/4813/changing-modifier-keys-from-the-command-line)

To see device IDs use `hidutil list`.

### Flycut

Open Preference and set to Launch on login. Also can change icon.

### Rectangle

Import RectangleConfig.json to apply settings. The main ones are Open on login and using the default Rectangle hotkeys.

## Slack

Typical settings include

- Channels > Show & Sort > Show in this section > Unread only
- Preferences > Sidebar > Sort... > Alphabetically
- Preferences > Themes > Sync with OS setting
- Preferences > Messages & media > Show one-click reactions on messages > Show my most frequently used emoji
- Preferences > Advanced > Input Options > Format messages with markup
- Administration > Customize [Slack Team] > Add all the https://slackmojis.com/ lolz

## Updating

In general, you should be using symbolic links for everything, and using git submodules whenever possible.

To keep submodules at their proper versions, you could include something like git submodule update --init --recursive in your install.conf.yaml.

To upgrade your submodules to their latest versions, you could periodically run git submodule update --init --remote.

### Brewfile

Use the [brew bundle](https://docs.brew.sh/Manpage#bundle-subcommand) commands to manage brew installations.

- `brew bundle dump --force` - Updates `Brewfile` with all your dependencies, casks, taps and even services
- `brew bundle [install]` - Install all Brewfile dependencies. Automatically run on `./install`

Since brew autogenerates the file, review the file and re-add comments before committing.

## Modifying script permissions

To allow running a script, use the following `chmod` commmand with the path to the script file.

```bash
chmod +x ./path-to-script.sh
```

## Updating vscode extension list

Currently, the vscode extension list is not automatically updated. To update the `extensions.txt` file run the following command

```bash
code --list-extensions > ~/.dotfiles/vscode/extensions.txt
```

## Finding defaults from menus

Print the defaults to two files before and after the change and compare the two files.

```bash
defaults read com.apple.dock > defaults.txt
```
