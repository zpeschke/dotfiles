# Gnome Configuration

All of these settings are exported using `dconf`.

## Export

```
# window manager keybinds
dconf dump /org/gnome/desktop/wm/keybindings/

# custom keybinds
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/

# terminal
dconf dump /org/gnome/terminal/
```


