vim.api.nvim_create_augroup('vimrc', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = "*",
  group = "vimrc",
  callback = function (event)
    local dir = vim.fs.dirname(event.file)
    if vim.fn.isdirectory(dir) ~= 1 then
      print("this is not exist directory")
      print(vim.v.cmdbang)
      -- vim.
    end
  end
})

vim.api.nvim_create_augroup('restore-ime', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  pattern = "*",
  group = "restore-ime",
  callback = function (event)
    -- hoge
  end
})

