local M = {}

function M.setup()
  local wiki_dir = vim.fn.expand '~' .. '/wiki'
  if vim.fn.empty(vim.fn.glob(wiki_dir)) > 0 then
    vim.fn.system { 'mkdir', '-p', wiki_dir }
  end

  -- this is only useful for lervag/wiki.vim
  vim.g.wiki_root = wiki_dir

  -- this is for vimwiki/vimwiki
  local wiki = {}
  wiki.path = wiki_dir
  vim.g.vimwiki_list = { wiki }
  vim.g.vimwiki_conceallevel = 0
end

return M
