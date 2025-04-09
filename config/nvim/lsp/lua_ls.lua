local wezterm_path

if vim.fn.isdirectory("/opt/homebrew/share/wezterm") == 1 then
  -- Apple Silicon Mac
  wezterm_path = "/opt/homebrew/share/wezterm"
elseif vim.fn.isdirectory("/usr/local/share/wezterm") == 1 then
  -- Intel Mac または Linux
  wezterm_path = "/usr/local/share/wezterm"
end

return {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },

  -- Filetypes to automatically attach to.
  filetypes = { 'lua' },

  -- Sets the "root directory" to the parent directory of the file in the
  -- current buffer that contains either a ".luarc.json" or a
  -- ".luarc.jsonc" file. Files that share a root directory will reuse
  -- the connection to the same LSP server.
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },

  -- Specific settings to send to the server. The schema for this is
  -- defined by the server. For example the schema for lua-language-server
  -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			format = {
				-- Use stylua
				enable = false,
			},
			diagnostics = {
				globals = {
					"vim",
					"describe",
					"it",
					"before_each",
					"after_each",
					"setup",
					"teardown",
          "wezterm"
				},
			},
			semantic = {
				enable = false,
			},
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("data") .. "/lazy",
        },
			},
			hint = {
				enable = true,
			},
		},
	},
}
