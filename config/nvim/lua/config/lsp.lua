vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.buf.hover({border = 'rounded'})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.buf.signature_help({border = 'rounded'})

vim.lsp.enable {
  "ts_ls",
  "denols",
  "lua_ls",
  -- "efm",
}

