local lspconfig = require("lspconfig")

return {
  -- `util.find_package_json_ancestor`:
  -- a function that locates the first parent directory containing a `package.json`.
  root_dir = lspconfig.util.find_package_json_ancestor,
  single_file_support = false,
  -- init_options = {
  -- }
}
