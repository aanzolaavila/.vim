return {
  'vimwiki/vimwiki',
  config = function()
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

    local wiki_group = vim.api.nvim_create_augroup('Wiki', { clear = true })

    -- Auto format lines on wiki files
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.wiki",
      command = [[g/./ normal gqq``]],
      group = wiki_group,
    })

    -- no conceal on cursor
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "vimwiki",
      callback = function()
        vim.opt.concealcursor = 'c'
      end,
      group = wiki_group,
    })
  end
}
