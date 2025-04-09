-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

-- disable unused keys
set("n", "<Space>", "<Nop>")
set("n", ",", "<Nop>")
set("n", "s", "<Nop>")
set("n", "t", "<Nop>")
set("n", "m", "<Nop>")
set("n", "Q", "<Nop>")

-- swap colon and semicolon
set("n", ";", ":")

-- clear hilight
set("n", "<Esc><Esc>", "<Cmd>nohl<CR>")

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- You can search each function in the help page.
		-- For example :help vim.lsp.buf.hover()

		bufmap("n", "K", vim.lsp.buf.hover)
		bufmap("n", "gd", vim.lsp.buf.definition)
		bufmap("n", "gD", vim.lsp.buf.declaration)
		bufmap("n", "gI", vim.lsp.buf.implementation)
		bufmap("n", "gy", vim.lsp.buf.type_definition)
		bufmap("n", "gr", vim.lsp.buf.references)
		bufmap("n", "<C-k>", vim.lsp.buf.signature_help)
		bufmap("n", "<Leader>cr", vim.lsp.buf.rename)
		bufmap("n", "<Leader>ca", vim.lsp.buf.code_action)
		bufmap("n", "gl", vim.diagnostic.open_float)
		bufmap("n", "[d", vim.diagnostic.goto_prev)
		bufmap("n", "]d", vim.diagnostic.goto_next)
	end,
})

-- disable IME on NormalMode
if vim.fn.executable("fcitx5") then
  ---@type number
  local fcitx_previous_state = 1
  local fcitx_savestate = vim.api.nvim_create_augroup("FcitxSaveStatus", { clear = true })
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      fcitx_previous_state = tonumber(vim.fn.system("fcitx5-remote")) or 1
      vim.fn.system("fcitx5-remote -c")
    end,
    group = fcitx_savestate,
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      vim.fn.system("fcitx5-remote " .. (fcitx_previous_state == 1 and "-c" or "-o"))
    end,
    group = fcitx_savestate,
  })
end
