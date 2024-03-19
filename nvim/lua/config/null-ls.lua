local has_null_ls, null_ls = pcall(require, "null-ls")
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

local sources = has_null_ls
		and {
			-- Anything not supported by mason.
			-- null_ls.builtins.formatting.stylelint,
			-- null_ls.builtins.formatting.stylua,
			-- null_ls.builtins.formatting.eslint_d,
			-- null_ls.builtins.formatting.black,
			-- null_ls.builtins.formatting.goimports,
			-- null_ls.builtins.formatting.rustfmt,
			-- null_ls.builtins.formatting.shfmt,
			-- null_ls.builtins.formatting.sqlformat
		}
	or {}

return {
	sources = sources,
	on_attach = on_attach,
}
