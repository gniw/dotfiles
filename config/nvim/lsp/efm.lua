-- !! efm-langserver could not deal eslint codeaction !! --

-- Register linters and formatters per language
local eslint = require('efmls-configs.linters.eslint_d')
local prettier = require('efmls-configs.formatters.prettier_d')

local override_languages = function ()
  local languages = {}
  for _, ft in ipairs({
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  }) do
    languages[ft] = { eslint, prettier }
  end
  return languages
end

local languages = vim.tbl_extend(
  'force',
  require('efmls-configs.defaults').languages(),
  override_languages()
)

return {
  filetypes = vim.tbl_keys(languages),
  cmd = {
    "efm-langserver",
  },
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true
  },
}
