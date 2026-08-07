# dotfiles

Herein lies my dotfile config

Managed via [Dotbot](https://github.com/anishathalye/dotbot/)

# Applying dotfiles

**Warning: This will override your existing settings**

```bash
./install
```

Note: If brew is not previously installed, you will need to follow the additional instructions from brew before re-running.

## Preflight

Before running `./install`, confirm:

- macOS with internet access (bootstrap scripts download installers).
- Xcode Command Line Tools can be installed (`xcode-select --install`).
- `curl` is available (used by Homebrew and oh-my-zsh installers).

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

- `brew bundle dump --force` - Updates `Brewfile` with dependencies, casks, taps, MAS apps, and VS Code extensions
- `brew bundle [install]` - Install all Brewfile dependencies. Automatically run on `./install`

Since brew autogenerates the file, review the file and re-add comments before committing.

### Brewfile Refresh Workflow

Use the local refresh script to keep `Brewfile` aligned with your machine and annotation rules:

```bash
./scripts/brewfile-refresh.sh
git --no-pager diff -- Brewfile
```

The script:

- Exports current packages from Homebrew Bundle.
- Applies `brewfile-annotations.yaml` (`optional`, `excluded`, and comments).
- Writes changes directly to `Brewfile`.

Bootstrap note:

- `scripts/brew-install.sh` installs Homebrew from the official installer URL.
- `scripts/shell.sh` installs oh-my-zsh from the official installer URL.

## Maintenance

Regularly:

1. `brew update`
2. `brew bundle check --file Brewfile`
3. `./scripts/validate.sh`
4. `./scripts/brewfile-refresh.sh`
5. Review `git --no-pager diff -- Brewfile`

Infrequently:

1. `brew outdated`
2. `git submodule update --init --recursive`
3. Optionally update submodules in a dedicated branch with `git submodule update --remote --recursive`

## Local validation

Run all local checks with one command:

```bash
./scripts/validate.sh
```

This validates:

- `install.conf.yaml` YAML parse
- JSONC syntax for VS Code config files and JSON syntax for Rectangle config
- shell syntax for `install` and `scripts/*.sh`
- Dotbot dry-run
- `brew bundle check --file Brewfile`

## Modifying script permissions

To allow running a script, use the following `chmod` commmand with the path to the script file.

```bash
chmod +x ./path-to-script.sh
```

## Finding defaults from menus

Print the defaults to two files before and after the change and compare the two files.

```bash
defaults read com.apple.dock > defaults.txt
```
