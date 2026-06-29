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

### Shell & terminal

| Software    | Purpose            | Config             |
|-------------|--------------------|--------------------|
| `fish`      | Interactive shell  | `fish/`            |
| `ghostty`   | Terminal emulator  | `ghostty/config`   |
| `starship`  | Prompt             | `starship.toml`    |

### Editors

| Software  | Purpose               | Config                |
|-----------|-----------------------|-----------------------|
| `helix`   | Modal text editor     | `helix/`              |
| `zed`     | GUI code editor       | `zed/`                |
| `spicetify` | Spotify theme patch | `spicetify/config-xpui.ini` |

### System tools

| Software | Purpose                       | Config           |
|----------|-------------------------------|------------------|
| `btop`   | System monitor                | `btop/btop.conf` |
| `cava`   | Audio visualizer              | `cava/`          |
| `fcitx5` | Input method framework        | (autostart in sway) |
| `playerctl` | Media key control          | (keybinds)       |
| `wpctl`  | PipeWire volume control       | (keybinds)       |
| `brightnessctl` | Backlight control       | (keybinds)       |
| `grim` + `slurp` | Screenshots           | (keybinds)       |
| `wl-copy` | Wayland clipboard             | (screenshot)     |
| `swaymsg`, `pkill` | Session control      | (keybinds)       |

## Layout

```
.
├── .gitignore
├── README.md
├── starship.toml
├── btop/
├── cava/
├── fish/
├── fuzzel/
├── ghostty/
├── helix/
├── i3status-rust/
├── mako/
├── spicetify/
├── sway/
├── swaylock/
├── wlogout/
└── zed/
```

## Install

Each tool reads its config from `~/.config/<tool>/`. Symlink (or copy) the
matching directory in this repo to `~/.config/`:

```sh
git clone https://github.com/wqLouis/dotfiles.git ~/dotfiles
cd ~/dotfiles
for d in btop cava fish fuzzel ghostty helix i3status-rust mako spicetify sway swaylock wlogout zed; do
    ln -sf "$PWD/$d" "$HOME/.config/$d"
done
ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
```

Drop extra Sway snippets into `~/.config/sway/config.d/*.conf` (sway's
`include` line picks them up automatically).

## Required packages (Arch)

```sh
pacman -S sway swaybg swayidle swaylock mako fuzzel i3status-rust \
            fish ghostty starship btop cava grim slurp wl-clipboard \
            playerctl wireplumber brightnessctl fcitx5 fcitx5-gtk \
            fcitx5-qt waybar-protocol-clipboard
```

Editors:

```sh
pacman -S helix zed
yay -S spicetify-cli
```

## Notes

- Theme: **Catppuccin Mocha** is used by sway, fuzzel, mako, swaylock, i3status-rust, ghostty, fish, starship, and wlogout.
- Wallpaper: set `SWAYBG_IMAGE=/path/to/wallpaper.jpg` before launching sway, or drop `wallpaper.jpg` at `~/Pictures/wallpaper/wallpaper.jpg`.
- wlogout `style.css` uses absolute paths under `/home/wqlouis/.config/wlogout/icons/`; edit if your username differs.
