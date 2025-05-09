local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local default_config = wezterm.config_builder()

require("format-tab-title")

--  creates a default window but makes it maximize on startup
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

default_config = {
  -- ディレクトリ変更を検出するためのOSC 7 サポートを有効化
  term = "wezterm",
  -- OSC 7 シーケンスをキャプチャするための設定
  bypass_mouse_reporting_modifiers = "SHIFT",
	font = wezterm.font_with_fallback({
    { family = "Moralerspace Krypton HWNF" },
    { family = "Moralerspace Krypton HWNF", assume_emoji_presentation = true },
  }),
	font_size = 14,
	adjust_window_size_when_changing_font_size = false,
	dpi = 144,
	audible_bell = "Disabled",

  -- tabs
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  window_decorations = "RESIZE",
  tab_max_width = 40,

	window_frame = {
		font_size = 12,
	},

	color_scheme = "Hybrid",
  window_background_opacity = 0.95,

	-- key binding
	disable_default_key_bindings = true,
	leader = {
		key = "t",
		mods = "CTRL",
		timeout_milliseconds = 2000,
	},
	keys = {
		{ key = "0", mods = "CTRL", action = act.PaneSelect },
		{
			key = "w",
			mods = "LEADER|CTRL",
			action = act.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "a",
			mods = "LEADER|CTRL",
			action = act.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "s",
			mods = "LEADER|CTRL",
			action = act.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "d",
			mods = "LEADER|CTRL",
			action = act.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "h",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "c",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "s",
			mods = "LEADER",
			action = act.SplitPane({
				direction = "Down",
				size = { Percent = 50 },
			}),
		},
		{
			key = "v",
			mods = "LEADER",
			action = act.SplitPane({
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			key = "q",
			mods = "LEADER",
			action = act.CloseCurrentPane({
				confirm = true,
			}),
		},
		{
			key = "Q",
			mods = "LEADER",
			action = act.QuitApplication,
		},
		{
			key = "/",
			mods = "LEADER",
			action = act.QuickSelect,
		},
		{
			key = "\\",
			mods = "LEADER",
			action = act.ActivateCopyMode,
		},
		-- paste from the clipboard
		{
			key = "p",
			mods = "LEADER",
			action = act.PasteFrom("Clipboard"),
		},
    -- {
    --   key = "D",
    --   mods = "CTRL",
    --   action = act.ShowDebugOverlay,
    -- },
    {
      key = "]",
      mods = "LEADER",
      action = act.ActivateTabRelative(1),
    },
    {
      key = "[",
      mods = "LEADER",
      action = act.ActivateTabRelative(-1),
    },
    {
      key = "=",
      mods = "META",
      action = wezterm.action.IncreaseFontSize,
    },
    {
      key = "-",
      mods = "META",
      action = wezterm.action.DecreaseFontSize,
    },
	},
}

return default_config
