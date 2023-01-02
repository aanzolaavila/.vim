local M = {}

function M.setup()
  local wiki_dir = vim.fn.stdpath 'state' .. '/wiki'
  if vim.fn.empty(vim.fn.glob(wiki_dir)) > 0 then
    vim.fn.system { 'mkdir', '-p', wiki_dir }
  end

  vim.g.wiki_root = wiki_dir
end

return M
