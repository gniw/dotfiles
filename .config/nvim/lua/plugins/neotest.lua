local spec = {
  "nvim-neotest/neotest",
  dependencies = {
    -- dependencies
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- adapters
    "markemmons/neotest-deno",
    "nvim-neotest/neotest-jest",
  },
  cond = false,
  opts = {
    consumers = {
      always_open_output = function(client)
        local neotest = require("neotest")
        local async = require("neotest.async")
        client.listeners.results = function(adapter_id, results)
          local file_path = async.fn.expand("%:p")
          local row = async.fn.getpos(".")[2] - 1
          local position = client:get_nearest(file_path, row, {})
          if not position then
            return
          end
          local pos_id = position:data().id
          if not results[pos_id] then
            return
          end
          neotest.output.open({ position_id = pos_id, adapter = adapter_id })
        end
      end,
    },
    icons = {
      -- Ascii:
      -- { "/", "|", "\\", "-", "/", "|", "\\", "-"},
      -- Unicode:
      -- { "", "🞅", "🞈", "🞉", "", "", "🞉", "🞈", "🞅", "", },
      -- {"◴" ,"◷" ,"◶", "◵"},
      -- {"◢", "◣", "◤", "◥"},
      -- {"◐", "◓", "◑", "◒"},
      -- {"◰", "◳", "◲", "◱"},
      -- {"⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷"},
      -- {"⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"},
      -- {"⠋", "⠙", "⠚", "⠞", "⠖", "⠦", "⠴", "⠲", "⠳", "⠓"},
      -- {"⠄", "⠆", "⠇", "⠋", "⠙", "⠸", "⠰", "⠠", "⠰", "⠸", "⠙", "⠋", "⠇", "⠆"},
      -- { "⠋", "⠙", "⠚", "⠒", "⠂", "⠂", "⠒", "⠲", "⠴", "⠦", "⠖", "⠒", "⠐", "⠐", "⠒", "⠓", "⠋" },
      running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
      passed = "",
      running = "",
      failed = "",
      skipped = "",
      unknown = "",
      non_collapsible = "─",
      collapsed = "─",
      expanded = "╮",
      child_prefix = "├",
      final_child_prefix = "╰",
      child_indent = "│",
      final_child_indent = " ",
      watching = "",
    },
    summary = {
      animated = true,
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = "a",
        clear_marked = "M",
        clear_target = "T",
        debug = "d",
        debug_marked = "D",
        expand = { "<CR>", "<2-LeftMouse>" },
        expand_all = "e",
        jumpto = "i",
        mark = "m",
        next_failed = "J",
        output = "o",
        prev_failed = "K",
        run = "r",
        run_marked = "R",
        short = "O",
        stop = "u",
        target = "t"
      }
    }
  },
  config = function (_,opts)
    local adapters = {
      require "neotest-deno",
      require "neotest-jest",
    }
    local options = vim.tbl_deep_extend(
      "force",
      {},
      opts,
      adapters
    )
    require("neotest").setup(options)
  end
}

return spec
