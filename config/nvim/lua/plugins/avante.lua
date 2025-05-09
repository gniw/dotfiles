return {
  "yetone/avante.nvim",
  -- enabled = false,
  event = "VeryLazy",
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.



     

  config = function (_, opts)
  	require("avante").setup(opts)
  	-- INFO: fix the border highlights
  	vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { link = "AvanteSidebarWinHorizontalSeparator" })
  end,
  opts = {
    -- add any opts here
    -- for example
    provider = "copilot",
    copilot = {
      model = "claude-3.7-sonnet"
    },
    auto_suggestions_provider = "copilot",
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      minimize_diff = true,
    },
    windows = {
      position = "smart",
      wrap = true,
      width = 35,
      sidebar_header = {
        enabled = true,
        align = "right",
        rounded = true,
      },
      input = {
        height = 5,
      },
      edit = {
        border = "rounded",
        start_insert = true,
      },
      ask = {
        floating = true,
        start_insert = true,
        border = "rounded",
      },
    },

    -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub:get_active_servers_prompt()
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,

    file_selector = {
      provider = "snack",
    },
    -- MCPHub's built-in Neovim server provides most basic development tools by default.
    -- If you prefer using these built-in tools, you should disable the corresponding Avante tools to prevent duplication:
    disabled_tools = {
      "list_files",    -- Built-in file operations
      "search_files",
      "read_file",
      "create_file",
      "rename_file",
      "delete_file",
      "create_dir",
      "rename_dir",
      "delete_dir",
      "bash",         -- Built-in terminal access
    },
    -- provider settings
    -- copilot = {
    --     model = "gpt-4o-2024-05-13",
    --     -- model = "gpt-4o-mini",
    --     max_tokens = 4096,
    -- },

    -- provider = "claude"
    -- claude = {
    --     model = "claude-3-5-sonnet-20240620", -- $3/$15, maxtokens=8000
    --     -- model = "claude-3-opus-20240229",  -- $15/$75
    --     -- model = "claude-3-haiku-20240307", -- $0.25/1.25
    --     max_tokens = 8000,
    -- },

    -- provider = "openai",
    -- openai = {
    --   endpoint = "https://api.openai.com/v1",
    --   model = "gpt-4o", -- $2.5/$10
    --   model = "gpt-4o-mini", -- $0.15/$0.60
    --   timeout = 30000, -- timeout in milliseconds
    --   temperature = 0, -- adjust if needed
    --   max_tokens = 4096,
    --   -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
    -- },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
    -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "ravitemer/mcphub.nvim", -- for mcp servers
    {
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      cmd = "Copilot",
      event = "InsertEnter",
      opts = {},
      config = function()
        require("copilot").setup({})
      end,
    },
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
