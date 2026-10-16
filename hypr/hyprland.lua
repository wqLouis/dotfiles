-- ─────────────────────────────────────────────────────────────────────
-- Hyprland config — mirrors ~/.config/sway/config (and the mango one).
--
--   mainMod = ALT   (same as the sway/mango setup; resize + screenshot
--                    use SUPER, exactly like sway's Mod4 binds)
--
-- Hyprland 0.55+ uses a Lua config. API reference (typed stubs):
--   /usr/share/hypr/stubs/hl.meta.lua
-- Validate without starting a session:
--   Hyprland --verify-config -c ~/.config/hypr/hyprland.lua
-- ─────────────────────────────────────────────────────────────────────


-----------------
---- MONITORS ----
-----------------
-- sway: `output * scale 1`
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })


---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "ghostty"
local fileManager = "nautilus"
local browser     = "firefox"
local menu        = "fuzzel"


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Input method (fcitx5) — mirror ~/.config/environment.d/fcitx5.conf
hl.env("INPUT_METHOD", "fcitx")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")


------------------
---- AUTOSTART ----
------------------
-- sway: exec-once lines
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
    -- Input method
    hl.exec_cmd("fcitx5 -d --disable notificationitem")
    hl.exec_cmd("dbus-update-activation-environment --systemd INPUT_METHOD GTK_IM_MODULE QT_IM_MODULE XMODIFIERS SDL_IM_MODULE GLFW_IM_MODULE")
    -- Notifications, bar, wallpaper
    hl.exec_cmd("mako")
    hl.exec_cmd("waybar -c \"$HOME/.config/waybar/config.hyprland.jsonc\"")
    hl.exec_cmd("swaybg -i \"${SWAYBG_IMAGE:-$HOME/Pictures/wallpaper/wallpaper.jpg}\" -m fill")
end)


-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in      = 4,
        gaps_out     = 4,
        border_size  = 2,               -- sway: default_border pixel 2
        col = {
            active_border   = "rgba(89b4faff)",  -- Catppuccin Mocha blue
            inactive_border = "rgba(45475aff)",  -- surface1
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 0,             -- no rounded corners
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = { enabled = false },   -- sway had no shadows
        blur   = { enabled = false },   -- sway had no blur
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

-- Curves — Hyprland stock defaults (`speed` below is in ds: 1 = 100 ms)
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

-- Animations — Hyprland stock defaults, except the workspace switch which
-- slides (swipe) with an easeOutQuint curve instead of the stock `fade`.
-- NOTE: workspacesIn/workspacesOut are siblings of `workspaces` (not children),
-- so they must be set to slide too or the switch still fades.
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })


---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        accel_profile = "flat",        -- sway: accel_profile flat

        touchpad = {
            natural_scroll          = true,   -- sway: natural_scroll enabled
            disable_while_typing    = true,   -- sway: dwt enabled
            middle_button_emulation = true,   -- sway: middle_emulation enabled
            tap_to_click            = true,   -- sway: tap enabled
        },
    },
})

-- sway: bindgesture swipe:left/right workspace prev/next
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


---------------------
---- KEYBINDINGS ----
---------------------
local mainMod  = "ALT"
local superMod = "SUPER"

-- Basics
hl.bind(mainMod .. " + Q",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SPACE",     hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("pkill -x wlogout; sleep 0.2; wlogout -b 3"))

-- Focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Resize window (SUPER + WASD) — sway: Mod4+w/a/s/d resize
hl.bind(superMod .. " + W", hl.dsp.window.resize({ x = 0,   y = -32, relative = true }), { repeating = true })
hl.bind(superMod .. " + S", hl.dsp.window.resize({ x = 0,   y = 32,  relative = true }), { repeating = true })
hl.bind(superMod .. " + A", hl.dsp.window.resize({ x = -32, y = 0,   relative = true }), { repeating = true })
hl.bind(superMod .. " + D", hl.dsp.window.resize({ x = 32,  y = 0,   relative = true }), { repeating = true })

-- Switch / move to workspace by number (move also follows, like sway)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Prev / next workspace (sway: workspace prev/next)
hl.bind(mainMod .. " + A",         hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + D",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.move({ workspace = "e+1" }))

-- Layout controls (dwindle)
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.layout("togglesplit"))  -- sway: splitv
hl.bind(mainMod .. " + W",         hl.dsp.layout("togglesplit"))  -- sway: splith
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.group.toggle())         -- sway: layout stacking (tabbed)

-- Mouse drag / resize with mainMod (sway: floating_modifier Mod1)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Screenshot (SUPER + SHIFT + S)
hl.bind(superMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | wl-copy"))


-------------------------------
---- WINDOWS AND WORKSPACES ----
-------------------------------
-- Ignore maximize requests from all apps.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix dragging issues with XWayland.
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- sway: for_window [app_id="file_progress"] floating enable, sticky enable
hl.window_rule({
    name  = "float-file-progress",
    match = { class = "file_progress" },
    float = true,
    pin   = true,
})

-- sway floated [window_role="pop-up"] / [window_role="dialog"]. Hyprland has
-- no window_role match; modal dialogs are the closest equivalent.
hl.window_rule({
    name  = "float-modal-dialogs",
    match = { modal = true },
    float = true,
    center = true,
})

-- Hyprland-run windowrule (from the stock config)
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
