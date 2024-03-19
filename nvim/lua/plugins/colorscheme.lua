local spec = {
	-- colorscheme
	{
		"w0ng/vim-hybrid",
    lazy = false,
		config = function()
			vim.cmd([[ colorscheme hybrid ]])
		end,
	},
}

return spec
