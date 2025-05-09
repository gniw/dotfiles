-- You need to clone the repo under ~/projects then you create ~./config/nvim/lua/[plugin_name].lua containing:
-- return {
--     "[plugin_name]",
--     name = "[plugin_name]",
--     dev = {true}
-- }
return {
  'creativenull/efmls-configs-nvim',
  name = 'creativenull/efmls-configs-nvim',
  dev = true,
  enabled = false,
}
