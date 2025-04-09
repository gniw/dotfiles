-- We almost always start by importing the wezterm module
local wezterm = require 'wezterm'

local HEADER = '   '

local SYMBOL_COLOR = { '#ffb2cc', '#a4a4a4' }
local FONT_COLOR = { '#dddddd', '#888888' }
local BACK_COLOR = '#2d2d2d'
local HOVER_COLOR = '#434343'

-- 各タブの「ブランチ名:ディレクトリ名」を記憶しておくテーブル
local title_cache = {}

-- 現ディレクトリとgitブランチ名を取得
local function set_title(pane)
  local cwd_uri = pane:get_current_working_dir()

  local cwd_uri_string = wezterm.to_string(cwd_uri)
  local cwd = cwd_uri_string:gsub("^file://", "")

  if (not cwd) then
    return nil
  end

  -- Gitのブランチ名を取得
  local success, stdout, stderr = wezterm.run_child_process({
    "git", "-C", cwd, "branch", "--show-current"
  })

  local current_dir = cwd:match("^.*/(.*)$")

  local ret = current_dir

  -- Gitブランチ名を取得できたら「ブランチ名:ディレクトリ名」と表示できるようにする
  if success then
    local branch = stdout:gsub("%s+", "")
    ret = branch .. ':' .. current_dir
  end

  return ret
end

-- 各タブ（正確にはpane）に「ブランチ名:ディレクトリ名」を記憶させる
wezterm.on("update-status", function(window, pane)

  local title = set_title(pane)
  local pane_id = pane:pane_id()

  title_cache[pane_id] = title
end)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local index = tab.is_active and 1 or 2
    local bg = hover and HOVER_COLOR or BACK_COLOR
    local title = tab.active_pane.title

    local pane = tab.active_pane
    local pane_id = pane.pane_id

    -- 記憶させていた「ブランチ名:ディレクトリ名」を取り出す
    if title_cache[pane_id] then
      title = title_cache[pane_id]
    end

    return {
      { Foreground = { Color = SYMBOL_COLOR[index] } },
      { Background = { Color = bg } },
      { Text = HEADER },

      { Foreground = { Color = FONT_COLOR[index] } },
      { Background = { Color = bg } },
      { Text = title },
    }
  end
)

