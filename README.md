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