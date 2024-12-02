local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

---
-- Mason.nvim
---
-- See :help mason-settings
require('mason').setup({
  ui = {
		border = 'rounded',
    icons = {
       package_installed = "✓",
       package_pending = "➜",
       package_uninstalled = "✗",
     }
	}
})

-- See :help mason-lspconfig-settings
require('mason-lspconfig').setup({
  ensure_installed = {
		"sumneko_lua",
		"tsserver",
		"html"
  },
	automatic_installation = true,
})

---
-- LSP config
---
-- See :help lspconfig-global-defaults
local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
  end
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

---
-- Diagnostic customization
---
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

-- sign({name = 'DiagnosticSignError', text = '✘'})
-- sign({name = 'DiagnosticSignWarn', text = '▲'})
-- sign({name = 'DiagnosticSignHint', text = '⚑'})
-- sign({name = 'DiagnosticSignInfo', text = ''})

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd('User', {
  pattern = 'LspAttached',
  group = group,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- You can search each function in the help page.
    -- For example :help vim.lsp.buf.hover()

    bufmap( 'n', 'K', vim.lsp.buf.hover )
    bufmap( 'n', 'gd', vim.lsp.buf.definition )
    bufmap( 'n', 'gD', vim.lsp.buf.declaration )
    bufmap( 'n', 'gi', vim.lsp.buf.implementation )
    bufmap( 'n', 'go', vim.lsp.buf.type_definition )
    bufmap( 'n', 'gr', vim.lsp.buf.references )
    bufmap( 'n', '<C-k>', vim.lsp.buf.signature_help )
    bufmap( 'n', '<Leader>r', vim.lsp.buf.rename )
    bufmap( 'n', '<Leader>a', vim.lsp.buf.code_action )
    bufmap( 'x', '<Leader>a', vim.lsp.buf.code_action )
    bufmap( 'n', 'gl', vim.diagnostic.open_float )
    bufmap( 'n', '[d', vim.diagnostic.goto_prev )
    bufmap( 'n', ']d', vim.diagnostic.goto_next )
  end
})


---
-- LSP servers
---
local default_handler = function(server)
  -- See :help lspconfig-setup
  lspconfig[server].setup({})
end

-- load plugins
require("mason-lspconfig").setup_handlers({
  default_handler,
  ['tsserver'] = function()
    lspconfig.tsserver.setup({
      settings = {
        completions = {
          completeFunctionCalls = true
        }
      }
    })
  end,
  ['sumneko_lua'] = function ()
    lspconfig.sumneko_lua.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              'vim',
            }
          }
        }
      }
    })
  end,
})
