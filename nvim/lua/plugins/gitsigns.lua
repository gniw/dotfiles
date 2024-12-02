local on_attach = function(bufnr)
	local gitsigns = require("gitsigns")

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end)

	map("n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end)

	-- Actions
	map("n", "<leader>hs", gitsigns.stage_hunk)
	map("n", "<leader>hr", gitsigns.reset_hunk)
	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end)
	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end)
	-- map('n', '<leader>hS', gitsigns.stage_buffer)
	-- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
	-- map('n', '<leader>hR', gitsigns.reset_buffer)
	map("n", "<leader>hp", gitsigns.preview_hunk)
	map("n", "<leader>hb", function()
		gitsigns.blame_line({ full = true })
	end)
	-- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
	map('n', '<leader>hd', gitsigns.diffthis)
	map("n", "<leader>hD", function()
		gitsigns.diffthis("~")
	end)
	map("n", "<leader>td", gitsigns.toggle_deleted)

	-- Text object
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

local current_line_blame_opts = {
	virt_text = true,
	virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
	delay = 0,
	ignore_whitespace = false,
	virt_text_priority = 100,
	use_focus = true,
}

local spec = {
	"lewis6991/gitsigns.nvim",
	opts = {
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    current_line_blame = true,
    current_line_blame_opts = current_line_blame_opts,
    on_attach = on_attach,
  },
}

return spec
