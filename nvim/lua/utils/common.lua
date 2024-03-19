local M = {}

M.map = function (args)
  local options = { noremap = true }
	local mode, lhs, rhs, opts = unpack(args)
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
	vim.keymap.set(mode, lhs, rhs, options)
end


M.dumpTable = function (self, table, depth)
  depth = depth or 1
  if (depth > 200) then
    print("Error: Depth > 200 in dumpTable()")
    return
  end
  for k,v in pairs(table) do
    if (type(v) == "table") then
      print(string.rep("  ", depth)..k..":")
      self:dumpTable(v, depth+1)
    else
      print(string.rep("  ", depth)..k..": ",v)
    end
  end
end

-- M.dumpTable = dumpTable

return M
