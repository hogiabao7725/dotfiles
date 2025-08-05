-- ~/.config/wezterm/configs/appearance.lua

local wezterm = require 'wezterm'

local M = {}

-- Font settings
M.font = wezterm.font("JetbrainsMono Nerd Font Mono", { weight = "Regular" })
M.font_size = 13

-- Color scheme
M.color_scheme = "Tokyo Night"

-- Opacity settings
M.text_background_opacity = 1.0
M.window_background_opacity = 0.9

-- Cursor settings
M.default_cursor_style = "BlinkingBar"
M.cursor_blink_rate = 500

-- M.window_frame = {
--   border_left_width = '1.5px',
--   border_right_width = '1.5px',
--   border_bottom_height = '1.5px',
--   border_top_height = '1.5px',
--
--   border_left_color = '#5c7aff',
--   border_right_color = '#5c7aff',
--   border_bottom_color = '#5c7aff',
--   border_top_color = '#5c7aff',
-- }

return M
