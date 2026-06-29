# dotfiles

Personal config repository for a Sway-based Wayland desktop on Arch Linux.
Themed with **Catppuccin Mocha** throughout.

## Software

### Wayland compositor stack

| Software         | Purpose                              | Config                  |
|------------------|--------------------------------------|-------------------------|
| `sway`           | Tiling Wayland compositor            | `sway/config`           |
| `swaybg`         | Wallpaper daemon                     | (env: `SWAYBG_IMAGE`)   |
| `swayidle`       | Idle/screen-lock manager             | (in `sway/config`)      |
| `swaylock`       | Screen locker                        | `swaylock/config`       |
| `wlogout`        | Logout/power menu                    | `wlogout/{layout,style.css,icons/}` |
| `mako`           | Notification daemon                  | `mako/config`           |
| `fuzzel`         | Application launcher                 | `fuzzel/fuzzel.ini`     |
| `i3status-rust`  | Status bar (Sway bar backend)        | `i3status-rust/config.toml` |

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
├── i3status-rust/
├── mako/
├── sway/
├── swaylock/
└── wlogout/
```

## Install

Each tool reads its config from `~/.config/<tool>/`. Symlink (or copy) the
matching directory in this repo to `~/.config/`:

```sh
git clone https://github.com/wqLouis/dotfiles.git ~/dotfiles
cd ~/dotfiles
for d in fish fuzzel ghostty i3status-rust mako sway swaylock wlogout; do
    ln -sf "$PWD/$d" "$HOME/.config/$d"
done
ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
```

Drop extra Sway snippets into `~/.config/sway/config.d/*.conf` (sway's
`include` line picks them up automatically).

## Required packages (Arch)

```sh
pacman -S sway swaybg swayidle swaylock mako fuzzel i3status-rust \
            fish ghostty starship grim slurp wl-clipboard \
            playerctl wireplumber brightnessctl fcitx5 fcitx5-gtk \
            fcitx5-qt
```

## Notes

- Theme: **Catppuccin Mocha** is used by sway, fuzzel, mako, swaylock, i3status-rust, ghostty, fish, starship, and wlogout.
- Wallpaper: set `SWAYBG_IMAGE=/path/to/wallpaper.jpg` before launching sway, or drop `wallpaper.jpg` at `~/Pictures/wallpaper/wallpaper.jpg`.
- wlogout `style.css` uses absolute paths under `/home/wqlouis/.config/wlogout/icons/`; edit if your username differs.
