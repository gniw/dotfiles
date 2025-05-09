local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- you can reuse a shared lspconfig on_attach callback here
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
        -- vim.lsp.buf.formatting_sync()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

return {
  enabled = true,
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.root_dir = opts.root_dir
      or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.prettierd,
      require("none-ls.code_actions.eslint_d"),
      require("none-ls.diagnostics.eslint_d"),
    })
    opts.on_attach = on_attach
  end,
}
