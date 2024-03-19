local set = vim.opt

-- leader
vim.g.mapleader = "'"

-- options
set.clipboard:append { 'unnamedplus' }
set.laststatus = 3
set.shiftwidth = 2
set.tabstop = 2
set.number = true
set.wrap = false
set.signcolumn = "yes"
set.expandtab = true
set.mouse = ""
set.foldmethod = 'marker'
set.termguicolors = true
set.whichwrap:append {
	["h"] = true,
	["l"] = true,
	["<"] = true,
	[">"] = true,
	["["] = true,
	["]"] = true,
	["~"] = true,
}
set.backspace = { 'start', 'eol', 'indent' }
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
set.fileencodings = { 'ucs-bom', 'utf-8', 'sjis', 'default' }
