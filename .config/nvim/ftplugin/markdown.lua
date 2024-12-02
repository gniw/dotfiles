local set = vim.opt_local

set.list = true
set.listchars = {
	tab = "»-",
	trail = "-",
	eol = "↲",
	extends = "»",
	precedes = "«",
}

vim.api.nvim_buf_set_keymap(0, "n", "<LocalLeader>p", "<Plug>MarkdownPreviewToggle", { silent = true })
