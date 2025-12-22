-- ~/.config/wezterm/configs/appearance.lua

local wezterm = require("wezterm")

local M = {}

-- Font settings
M.font = wezterm.font("JetbrainsMono Nerd Font Mono", { weight = "Medium" })
M.font_size = 13.5

-- Color scheme
M.color_scheme = "Tokyo Night Storm"

-- Opacity settings
M.text_background_opacity = 1.0
M.window_background_opacity = 1.0

-- Cursor settings
M.default_cursor_style = "BlinkingBar"
M.cursor_blink_rate = 500

M.window_frame = {
	border_left_width = "2px",
	border_right_width = "2px",
	border_bottom_height = "2px",
	border_top_height = "2px",

	border_left_color = "#7aa2f7",
	border_right_color = "#7aa2f7",
	border_bottom_color = "#7aa2f7",
	border_top_color = "#7aa2f7",
}

return M
