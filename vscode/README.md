# VSCode configurations

By default, VSCode looks in the .VSCode directory for `extensions` and `snippets`. But we've also added `settings.json` and `keybindings.json` in this directory to have version control for these.

# Symlink settings and keybindings:
> Resource: https://pawelgrzybek.com/sync-vscode-settings-and-snippets-via-dotfiles-on-github/

```
$ ln -s /Users/jgesualdo/dotfiles/VSCode/settings.json /Users/jgesualdo/Library/Application\ Support/Code/User/settings.json
```

```
$ ln -s /Users/jgesualdo/dotfiles/VSCode/keybindings.json /Users/jgesualdo/Library/Application\ Support/Code/User/keybindings.json
```
