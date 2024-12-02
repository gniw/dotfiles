local spec = {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		---@class PluginLspOpts
		opts = {
			-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the inlay hints.
			inlay_hints = {
				enabled = false,
			},
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {}
			)

			local function setup(server)
				local has_handler, handler = pcall(require, "plugins.lsp." .. server)
				local server_opts = vim.tbl_deep_extend(
					"force",
					{ capabilities = vim.deepcopy(capabilities) },
					has_handler and handler or {}
				)
				require("lspconfig")[server].setup(server_opts)
			end

			if have_mason then
				mlsp.setup({ handlers = { setup } })
			end
		end,
	},
}

return spec
