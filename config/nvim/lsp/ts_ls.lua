return {
	-- Find the first parent directory containing a `package.json`.
	root_markers = {
		"package.json",
		"tsconfig.json",
		"jsconfig.json",
	},
	cmd = {
		"typescript-language-server",
		"--stdio",
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	-- on_attach = function()
	-- 	print("ts_ls is attached!!")
	-- end,
	-- init_options = {
	-- }
}

