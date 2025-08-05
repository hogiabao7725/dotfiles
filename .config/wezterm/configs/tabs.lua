-- ~/.config/wezterm/configs/tabs.lua
-- Tab Bar Configuration

local wezterm = require 'wezterm'
local M = {}

-- Tab Bar Settings
M.enable_tab_bar = true
M.tab_bar_at_bottom = true
M.use_fancy_tab_bar = false
M.tab_max_width = 40

-- Color Scheme
M.colors = {
  tab_bar = {
    -- Tab bar background
    background = '#24283b',

    -- Active tab
    active_tab = {
      bg_color = '#A5C261',
      fg_color = '#1E1E1E',
    },

    -- Inactive tabs
    inactive_tab = {
      bg_color = '#24283b',
      fg_color = '#565F89',
    },

    -- Inactive tab on hover
    inactive_tab_hover = {
      bg_color = '#2C314A',
      fg_color = '#D8DEE9',
    },

    -- "New Tab" button
    new_tab = {
      bg_color = '#414863',
      fg_color = '#A9B1D6',
    },
  },
}

return M
