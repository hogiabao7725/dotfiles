-- ~/.config/wezterm/configs/keybindings.lua

local wezterm = require("wezterm")
local M = {}

M.keys = {
	-- Keybinding to spawn a new tab with the desired working directory.
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({
			-- Explicitly set the new tab's working directory to the home directory
			-- or any other specific path.
			cwd = wezterm.home_dir,

			-- The command to run in the new tab.
			-- Replace with your preferred shell if it's not zsh.
			args = { "/usr/bin/fish", "--login" },
		}),
	},

	-- Close a tab
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentTab({
			confirm = true,
		}),
	},

	-- Navigate to the next tab
	{
		key = "e",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(1),
	},

	-- Navigate to the previous tab
	{
		key = "q",
		mods = "ALT",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	-- Switch directly to a specific tab using Ctrl + 1-9.
	-- The tab index starts from 0, so '1' corresponds to tab 0, '2' to tab 1, and so on.
	{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = wezterm.action.ActivateTab(8) },

	-- Split pane to the LEFT
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Left" }),
	},

	-- Split pane to the RIGHT
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Right" }),
	},

	-- Split pane UP
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Up" }),
	},

	-- Split pane DOWN
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane({ direction = "Down" }),
	},

	-- Close current pane (with confirmation)
	{
		key = "q",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

return M
