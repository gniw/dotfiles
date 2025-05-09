return {
  "olimorris/codecompanion.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" }
    },
  },
  opts = {
    adapters = {
      githubmodels = function ()
        return require("codecompanion.adapters").extend("githubmodels", {
          schema = {
            model = {
              default = "claude-3.7-sonnet"
            }
          }
        })
      end
    },
    strategies = {
      chat = {
        adapter = "githubmodels",
        tools = {
          ["mcp"] = {
            callback = function ()
              return require("mcphub.extensions.codecompanion")
            end,
            description = "Call tools and resources from the MCP Servers",
            opts = {
              requires_approval = true,
            },
          }
        }
      },
      inline = {
        adapter = "githubmodels",
      },
      cmd = {
        adapter = "githubmodels",
      },
    },
    opts = {
      -- Set debug logging
      log_level = "DEBUG",
    },
  },
}
