-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Gruvbox Dark (Gogh)"

config.font = wezterm.font("Monaco", { weight = "Regular" })
config.font_size = 12

-- Remove border that shows when using vim
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.audible_bell = "Disabled" -- disable the bell sound


config.set_environment_variables = {
	TERM = "tmux-256color",
}
config.keys = {
	-- Ensure Ctrl+A is passed to tmux
	{ key = "a", mods = "CTRL", action = wezterm.action.SendKey { key = "a", mods = "CTRL" } },
}

-- and finally, return the configuration to wezterm
return config
