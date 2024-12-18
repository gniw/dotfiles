local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- if you want to set up formatting on save, you can use this as a callback
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
		async = false,
	})
end

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.prettierd.with({
    filetypes = { "css", "scss" },
  }),
  null_ls.builtins.formatting.biome.with({
    filetypes = { "javascript", "typescript" },
  }),
}

local spec = {
	"nvimtools/none-ls.nvim",
  opts = {
    sources = sources,
    on_attach = on_attach,
  }
}

return spec
