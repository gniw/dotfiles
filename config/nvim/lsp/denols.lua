return {
	root_dir = function(cb)
		local deno_root = vim.fs.root(0, { "deno.json", "deno.jsonc" })
		local node_root = vim.fs.root(0, { "package.json" })
		local current_buffer_path = vim.api.nvim_buf_get_name(0)
		print(current_buffer_path)
		-- if deno_root is found, but node_root is not found
		if not node_root and deno_root then
			cb(deno_root)
		end
		-- if neither deno_root nor node_root is not found
    if not node_root and deno_root then
      cb(current_buffer_path)
    end
	end,
	init_options = {
		enable = true,
		lint = true,
		unstable = true,
		suggest = {
			imports = {
				hosts = {
					["https://deno.land"] = true,
					["https://cdn.nest.land"] = true,
					["https://crux.land"] = true,
				},
			},
		},
	},
  cmd = {
    "deno",
    "lsp",
  },
  filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
  },
}
