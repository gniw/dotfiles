local utils = require("utils.common")

-- global
for _, key_mapping in pairs({
	-- disable unused keys
	{ "n", "<Space>", "<Nop>" },
	{ "n", ",", "<Nop>" },
	{ "n", "s", "<Nop>" },
	{ "n", "t", "<Nop>" },
	{ "n", "m", "<Nop>" },
	{ "n", "Q", "<Nop>" },
	-- swap colon and semicolon
	{ "n", ";", ":" },
	-- move quickfix
	{ "n", "[q", "<Cmd>cprevious<CR>" },
	{ "n", "]q", "<Cmd>cnext<CR>" },
	-- clear hilight
	{ "n", "<Esc><Esc>", "<Cmd>nohl<CR>" },
}) do
	utils.map(key_mapping)
end

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
		bufmap("n", "gi", vim.lsp.buf.implementation)
		bufmap("n", "go", vim.lsp.buf.type_definition)
		bufmap("n", "gr", vim.lsp.buf.references)
		bufmap("n", "<C-k>", vim.lsp.buf.signature_help)
		bufmap("n", "<Leader>r", vim.lsp.buf.rename)
		bufmap("n", "<Leader>a", vim.lsp.buf.code_action)
		bufmap("x", "<Leader>a", vim.lsp.buf.code_action)
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
