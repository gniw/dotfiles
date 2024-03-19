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

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				-- "flake8",
			},
			ui = {
				border = "rounded",
			},
		},

		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},

	-- null-ls
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local config = require("config.null-ls")
			require("null-ls").setup(config)
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		-- require("mason").setup()
		-- require("mason-null-ls").setup({
		--    ensure_installed = {
		--        -- Opt to list sources here, when available in mason.
		--    },
		--    automatic_installation = false,
		--    handlers = {},
		-- })
		-- require("null-ls").setup({
		--     sources = {
		--         -- Anything not supported by mason.
		--     }
		-- })
		opts = {
			ensure_installed = {
				"stylua",
				"biome",
				"prettierd",
			},
			methods = {
				formatting = true,
			},
			automatic_installation = false,
			handlers = {},
		},
	},
}

return spec
