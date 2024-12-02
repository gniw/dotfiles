local util = require("utils.common")

local spec = {
	"stevearc/oil.nvim",
	init = function()
		util.map({ "n", "-", "<CMD>Oil<CR>" })
	end,
	opts = {
		-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
		-- Additionally, if it is a string that matches "actions.<name>",
		-- it will use the mapping at require("oil.actions").<name>
		-- Set to `false` to remove a keymap
		-- See :help oil-actions for a list of all available actions
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-v>"] = "actions.select_vsplit",
			["<C-s>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["."] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gq"] = "actions.add_to_qflist",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},
		-- Configuration for the floating window in oil.open_float
		float = {
			-- Padding around the floating window
			padding = 0,
			max_width = math.floor(vim.o.columns * 0.65),
			max_height = math.floor(vim.o.lines * 0.45),
			border = "rounded",
			win_options = {
				winblend = 0,
			},
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			override = function(conf)
				return conf
			end,
		},
		view_options = {
			show_hidden = true,
		},
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

return spec
