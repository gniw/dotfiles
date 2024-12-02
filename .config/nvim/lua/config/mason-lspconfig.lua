local options = {
	ensure_installed = {
		"sumneko_lua",
		"tsserver",
	}
}

require("mason-lspconfig").setup(options)
