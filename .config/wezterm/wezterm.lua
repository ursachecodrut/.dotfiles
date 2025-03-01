local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Font
-- config.font = wezterm.font("DankMono Nerd Font Mono")
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0

-- Color scheme
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "rose-pine"
config.colors = {
	cursor_bg = "white",
	cursor_border = "white",
}

-- Appearance
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- Misscelaneous
config.max_fps = 60
config.prefer_egl = true

return config
