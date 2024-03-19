local util = require("utils.common")

local spec = {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function ()
    util.map({ "n", "<Leader>f", "<Cmd>FzfLua files<CR>" })
    util.map({ "n", "<Leader>b", "<Cmd>FzfLua buffers<CR>" })
    util.map({ "n", "<Leader>d", "<Cmd>FzfLua commands<CR>" })
    util.map({ "n", "<Leader>g", "<Cmd>FzfLua live_grep<CR>" })
  end,
  opts = {
    -- actions = {
    --   files = {
    --     -- ["default"] = function (selected, opts)
    --     --   local path = require("fzf-lua.path")
    --     --   local actions = require("fzf-lua.actions")

    --     --   local selected_item = selected[1]
    --     --   local status, entry = pcall(path.entry_to_file, selected_item, opts, opts.force_uri)
    --     --   local last_query = require("fzf-lua").config.__resume_data.last_query

    --     --   if selected_item and status and vim.loop.fs_stat(entry.path) then
    --     --     actions.file_edit(selected, opts)
    --     --   else
    --     --     vim.cmd("e " .. last_query)
    --     --   end
    --     -- end,
    --     -- providers that inherit these actions:
    --     --   files, git_files, git_status, grep, lsp
    --     --   oldfiles, quickfix, loclist, tags, btags
    --     --   args
    --     -- default action opens a single selection
    --     -- or sends multiple selection to quickfix
    --     -- replace the default action with the below
    --     -- to open all files whether single or multiple
    --     -- ["default"]     = actions.file_edit,
    --     ["default"]     = actions.file_edit_or_qf,
    --     ["ctrl-s"]      = actions.file_split,
    --     ["ctrl-v"]      = actions.file_vsplit,
    --     ["ctrl-t"]      = actions.file_tabedit,
    --     ["alt-q"]       = actions.file_sel_to_qf,
    --     ["alt-l"]       = actions.file_sel_to_ll,
    --   },
    --   buffers = {
    --     -- providers that inherit these actions:
    --     --   buffers, tabs, lines, blines
    --     ["default"]     = actions.buf_edit,
    --     ["ctrl-s"]      = actions.buf_split,
    --     ["ctrl-v"]      = actions.buf_vsplit,
    --     ["ctrl-t"]      = actions.buf_tabedit,
    --   }
    -- }
  },
  config = function(_, opts)
    -- calling `setup` is optional for customization
    require("fzf-lua").setup(opts)
  end
}

return spec
