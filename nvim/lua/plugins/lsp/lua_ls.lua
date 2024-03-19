return {
  settings = {
    Lua = {
      format = {
        -- Use stylua
        enable = false,
      },
      diagnostics = {
        globals = {
          "vim",
          "describe",
          "it",
          "before_each",
          "after_each",
          "setup",
          "teardown",
        },
      },
      semantic = {
        enable = false,
      },
      runtime = {
        version = "LuaJIT",
        path = { "?.lua", "?/init.lua" },
      },
      workspace = {
        checkThirdParty = false,
      },
      hint = {
        enable = true,
      },
    },
  },
}
