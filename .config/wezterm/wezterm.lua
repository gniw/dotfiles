local wezterm = require("wezterm")
local default_config = wezterm.config_builder()

local function table_merge(...)
	local tables_to_merge = { ... }
	assert(#tables_to_merge > 1, "There should be at least two tables to merge them")

	for k, t in ipairs(tables_to_merge) do
		assert(type(t) == "table", string.format("Expected a table as function parameter %d", k))
	end

	local result = tables_to_merge[1]

	for i = 2, #tables_to_merge do
		local from = tables_to_merge[i]
		for k, v in pairs(from) do
			if type(k) == "number" then
				table.insert(result, v)
			elseif type(k) == "string" then
				if type(v) == "table" then
					result[k] = result[k] or {}
					result[k] = table_merge(result[k], v)
				else
					result[k] = v
				end
			end
		end
	end

	return result
end

wezterm.log_info(wezterm.nerdfonts.dev_mozilla)

local my_config = {
	font = wezterm.font("Cica"),
	font_size = 14,
	adjust_window_size_when_changing_font_size = false,
	dpi = 144,
	audible_bell = "Disabled",

	window_frame = {
		font_size = 12,
	},

	color_scheme = "Hybrid",
	-- key binding
	disable_default_key_bindings = true,
	leader = {
		key = "t",
		mods = "CTRL",
		timeout_milliseconds = 1000,
	},
	keys = {
		{ key = "0", mods = "CTRL", action = wezterm.action.PaneSelect },
		{
			key = "w",
			mods = "LEADER|CTRL",
			action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "a",
			mods = "LEADER|CTRL",
			action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "s",
			mods = "LEADER|CTRL",
			action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "d",
			mods = "LEADER|CTRL",
			action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 50 },
			}),
		},
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			key = "q",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({
				confirm = true,
			}),
		},
		{
			key = "Q",
			mods = "LEADER",
			action = wezterm.action.QuitApplication,
		},
		{
			key = "/",
			mods = "LEADER",
			action = wezterm.action.QuickSelect,
		},
		{
			key = "\\",
			mods = "LEADER",
			action = wezterm.action.ActivateCopyMode,
		},
	},
}

local merged = table_merge(my_config, default_config)

return merged --my_config
