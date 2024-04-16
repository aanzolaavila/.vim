local M = {}

-- trims the prefix from a string
---@param s string
---@param p string
---@return string
function M.trim_prefix(s, p)
  return (s:sub(0, #p) == p) and s:sub(#p + 1) or s
end

return M
