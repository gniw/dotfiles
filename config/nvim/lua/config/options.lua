-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local set = vim.opt

-- leader
vim.g.mapleader = "'"
vim.g.maplocalleader = " "

-- options
---@diagnostic disable-next-line: undefined-field
set.clipboard:append({ "unnamedplus" })
set.laststatus = 3
set.shiftwidth = 2
set.tabstop = 2
set.number = true
set.wrap = false
set.signcolumn = "yes"
set.expandtab = true
set.mouse = ""
set.foldmethod = "marker"
set.termguicolors = true
set.whichwrap:append({
  ["h"] = true,
  ["l"] = true,
  ["<"] = true,
  [">"] = true,
  ["["] = true,
  ["]"] = true,
  ["~"] = true,
})
set.backspace = { "start", "eol", "indent" }
set.wildignore = {
  ".git",
  ".hg",
  ".svn",
  "*.pyc",
  "*.o",
  "*.out",
  "*.jpg",
  "*.jpeg",
  "*.png",
  "*.gif",
  "*.zip",
  "**/node_modules/**",
  "**/bower_modules/**",
  "__pycache__",
  "*~",
  "*.DS_Store",
}
set.fileencodings = { "ucs-bom", "utf-8", "sjis", "default" }

-- Prepend mise shims to PATH
-- vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
