return {
  "hkupty/iron.nvim",
  event = "VeryLazy",
  main = "iron.core", -- <== This informs lazy.nvim to use the entrypoint of `iron.core` to load the configuration.
  opts = function ()
    local set_keymap = vim.keymap.set
    local core = require("iron.core")
    local view = require("iron.view")
    local marks = require("iron.marks")

    local visual_send_and_move_down = function()
      core.visual_send()
      vim.cmd("normal! j")
    end

    local line_send_and_move_down = function()
      core.send_line()
      vim.cmd("normal! j")
    end

    set_keymap("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "Start Repl" })
    set_keymap("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "Restart Repl" })
    set_keymap("n", "<leader>rF", "<cmd>IronFocus<cr>", { desc = "Focus Repl" })
    set_keymap("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "Hide Repl" })
    set_keymap("n", "<leader>rc", core.send_motion, { desc = "Send motion" })
    set_keymap("n", "<leader>rf", core.send_file, { desc = "Send file" })
    set_keymap("n", "<leader>rl", core.send_line, { desc = "Send line" })
    set_keymap("n", "<C-CR>", line_send_and_move_down, { desc = "Send line" })
    set_keymap("n", "<leader>rms", core.send_mark, { desc = "Mark send" })
    set_keymap("n", "<leader>rmc", core.mark_motion, { desc = "Mark motion" })
    set_keymap("n", "<leader>rq", core.close_repl, { desc = "Exit" })
    set_keymap("n", "<leader>rmd", marks.drop_last, { desc = "Mark delete" })

    set_keymap("n", "<leader>r<CR>", function()
      core.send(nil, string.char(13))
    end, { desc = "Carriage return" })

    set_keymap("n", "<leader>r<space>", function()
      core.send(nil, string.char(03))
    end, { desc = "Interrupt" })

    set_keymap("n", "<leader>rx", function()
      core.send(nil, string.char(12))
    end, { desc = "Clear" })

    set_keymap("v", "<leader>rc", core.visual_send, { desc = "Send visual" })
    set_keymap("v", "<C-CR>", visual_send_and_move_down, { desc = "Send visual" })
    set_keymap("v", "<leader>rmc", core.mark_visual, { desc = "Mark visual" })

    return {
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          typescript = {
            command = { "deno", "repl" }
          },
          nix = {
            command = { "nix", "repl" }
          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        -- repl_open_cmd = require("iron.view").split.vertical.rightbelow(10),

        repl_open_cmd = view.split.vertical.rightbelow("%40"),
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true,
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
    }
  end,
  -- config = function (_, opts)
  --   local set_keymap = vim.keymap.set
  --   local core = require("iron.core")
  --   local marks = require("iron.marks")

  --   local visual_send_and_move_down = function()
  --     core.visual_send()
  --     vim.cmd("normal! j")
  --   end

  --   local line_send_and_move_down = function()
  --     core.send_line()
  --     vim.cmd("normal! j")
  --   end

  --   core.setup(opts)

  --   set_keymap("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "Start Repl" })
  --   set_keymap("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "Restart Repl" })
  --   set_keymap("n", "<leader>rF", "<cmd>IronFocus<cr>", { desc = "Focus Repl" })
  --   set_keymap("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "Hide Repl" })
  --   set_keymap("n", "<leader>rc", core.send_motion, { desc = "Send motion" })
  --   set_keymap("n", "<leader>rf", core.send_file, { desc = "Send file" })
  --   set_keymap("n", "<leader>rl", core.send_line, { desc = "Send line" })
  --   set_keymap("n", "<C-CR>", line_send_and_move_down, { desc = "Send line" })
  --   set_keymap("n", "<leader>rms", core.send_mark, { desc = "Mark send" })
  --   set_keymap("n", "<leader>rmc", core.mark_motion, { desc = "Mark motion" })
  --   set_keymap("n", "<leader>rq", core.close_repl, { desc = "Exit" })
  --   set_keymap("n", "<leader>rmd", marks.drop_last, { desc = "Mark delete" })

  --   set_keymap("n", "<leader>r<CR>", function()
  --     core.send(nil, string.char(13))
  --   end, { desc = "Carriage return" })

  --   set_keymap("n", "<leader>r<space>", function()
  --     core.send(nil, string.char(03))
  --   end, { desc = "Interrupt" })

  --   set_keymap("n", "<leader>rx", function()
  --     core.send(nil, string.char(12))
  --   end, { desc = "Clear" })

  --   set_keymap("v", "<leader>rc", core.visual_send, { desc = "Send visual" })
  --   set_keymap("v", "<C-CR>", visual_send_and_move_down, { desc = "Send visual" })
  --   set_keymap("v", "<leader>rmc", core.mark_visual, { desc = "Mark visual" })
  -- end,
}
