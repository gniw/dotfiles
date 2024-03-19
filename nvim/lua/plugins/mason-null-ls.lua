local spec = {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	opts = {
		ensure_installed = nil,
		methods = {
			formatting = true,
		},
		automatic_installation = true,
	},
}

return spec
