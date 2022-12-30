local M = {}

function M.setup()
  -- TODO: add command to create directory as wiki does not create it
  vim.g.wiki_root = vim.fn.stdpath 'state' .. '/wiki'
end

return M
