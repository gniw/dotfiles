local spec = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "html",
      "typescript",
      "javascript",
      "ruby",
      "rust",
      "scss",
      "css",
      "vim",
      "vimdoc",
      "lua",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function (_,opts)
    require("nvim-treesitter.configs").setup(opts)
  end
 }

 return spec
