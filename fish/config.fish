if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set --export EDITOR helix
set --export DOCKER_HOST "unix:///run/user/$(id -u)/podman/podman.sock"

fish_add_path /home/wqlouis/.spicetify
fish_add_path /home/wqlouis/.local/bin
fish_add_path /home/wqlouis/.cargo/bin

starship init fish | source
