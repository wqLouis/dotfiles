# dotfiles

Personal config repository for a Sway-based Wayland desktop on Arch Linux.
Themed with **Catppuccin Mocha** throughout.

## Software

### Wayland compositor stack

| Software         | Purpose                              | Config                  |
|------------------|--------------------------------------|-------------------------|
| `sway`           | Tiling Wayland compositor            | `sway/config`           |
| `swaybg`         | Wallpaper daemon                     | (env: `SWAYBG_IMAGE`)   |
| `wlogout`        | Logout/power menu                    | `wlogout/{layout,style.css,icons/}` |
| `mako`           | Notification daemon                  | `mako/config`           |
| `fuzzel`         | Application launcher                 | `fuzzel/fuzzel.ini`     |
| `waybar`         | Status bar (replaces i3status-rust + swaybar) | `waybar/{config.jsonc,style.css}` |

`mako` shows desktop notification popups (downloads finished, chat messages,
build results, low-battery warnings, etc.) — autostarted by `sway/config`.

### Shell & terminal

| Software    | Purpose            | Config             |
|-------------|--------------------|--------------------|
| `fish`      | Interactive shell  | `fish/`            |
| `ghostty`   | Terminal emulator  | `ghostty/config`   |
| `starship`  | Prompt             | `starship.toml`    |

### Editors

Editor configs are intentionally not tracked — install `helix` / `zed` /
`spicetify` / `cava` on a per-machine basis as needed.

### System tools

| Software | Purpose                       | Config           |
|----------|-------------------------------|------------------|
| `fcitx5` | Input method framework        | (autostart in sway) |
| `playerctl` | Media key control          | (keybinds)       |
| `wpctl`  | PipeWire volume control       | (keybinds)       |
| `brightnessctl` | Backlight control       | (keybinds)       |
| `grim` + `slurp` | Screenshots           | (keybinds)       |
| `wl-copy` | Wayland clipboard             | (screenshot)     |
| `swaymsg`, `pkill` | Session control      | (keybinds)       |

`btop` (system monitor), `cava` (audio visualizer) configs are intentionally
not tracked.

## Layout

```
.
├── .gitignore
├── README.md
├── starship.toml
├── fish/
├── fuzzel/
├── ghostty/
├── hypr/
├── mako/
├── sway/
├── waybar/
└── wlogout/
```

## Install

Each tool reads its config from `~/.config/<tool>/`. Symlink (or copy) the
matching directory in this repo to `~/.config/`:

```sh
git clone https://github.com/wqLouis/dotfiles.git ~/dotfiles
cd ~/dotfiles
for d in fish fuzzel ghostty hypr mako sway waybar wlogout; do
    ln -sf "$PWD/$d" "$HOME/.config/$d"
done
ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
```

Drop extra Sway snippets into `~/.config/sway/config.d/*.conf` (sway's
`include` line picks them up automatically).

### One-line install

Install every required package, clone this repo, and symlink every config into
`~/.config/` in a single command:

```sh
sudo pacman -S --needed - < <(echo "sway swaybg waybar wlogout mako fuzzel fish ghostty starship grim slurp wl-clipboard playerctl wireplumber brightnessctl fcitx5 fcitx5-gtk fcitx5-qt") && git clone https://github.com/wqLouis/dotfiles.git ~/dotfiles && cd ~/dotfiles && mkdir -p ~/.config && for d in fish fuzzel ghostty hypr mako sway waybar wlogout; do ln -sf "$PWD/$d" "$HOME/.config/$d"; done && ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
```

## Required packages (Arch)

```sh
pacman -S sway swaybg waybar wlogout mako fuzzel \
            fish ghostty starship grim slurp wl-clipboard \
            playerctl wireplumber brightnessctl fcitx5 fcitx5-gtk \
            fcitx5-qt
```

## Notes

- Theme: **Catppuccin Mocha** is used by sway, fuzzel, mako, waybar, ghostty, fish, starship, and wlogout.
- Hyprland: `hypr/hyprland.lua` is a Hyprland 0.55+ Lua config mirroring the Sway setup; it requires the `hyprland` package and loads `waybar/config.hyprland.jsonc`.
- Wallpaper: set `SWAYBG_IMAGE=/path/to/wallpaper.jpg` before launching sway, or drop `wallpaper.jpg` at `~/Pictures/wallpaper/wallpaper.jpg`.
- wlogout `style.css` uses absolute paths under `/home/wqlouis/.config/wlogout/icons/`; edit if your username differs.
