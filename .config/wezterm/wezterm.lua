-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'

local config = {}

-- Load utility functions
local utils = require 'utils'

-- Merge appearance and tab settings
local appearance = require 'configs.appearance'
utils.merge_tables_recursive(config, appearance)

local tabs = require 'configs.tabs'
utils.merge_tables_recursive(config, tabs)

local keybindings = require 'configs.keybindings'
utils.merge_tables_recursive(config, keybindings)

-- Global settings
-- config.default_prog = {'/usr/bin/zsh' }
config.default_prog = {'/usr/bin/zsh'}
config.initial_cols = 120
config.initial_rows = 30
config.window_decorations = "RESIZE"

return config
