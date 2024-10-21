return {
  'vimwiki/vimwiki',
  event = "VeryLazy",
  init = function()
    local wiki_dir = vim.fn.expand '~' .. '/wiki'
    if vim.fn.empty(vim.fn.glob(wiki_dir)) > 0 then
      vim.fn.system { 'mkdir', '-p', wiki_dir }
    end

    -- this is only useful for lervag/wiki.vim
    vim.g.wiki_root = wiki_dir
    vim.g.vimwiki_markdown_link_ext = 1
    vim.g.vimwiki_stripsym = ' '
    vim.g.vimwiki_global_ext = 0

    -- this is for vimwiki/vimwiki
    local general = {
      path = wiki_dir .. '/general',
      syntax = 'markdown',
      ext = 'md',
      list_margin = 0,
      diary_caption_level = -1,
    }

    local health = {
      path = wiki_dir .. '/health',
      syntax = 'default',
      ext = 'wiki',
      auto_generate_links = 1,
      auto_diary_index = 1,
      diary_frequency = 'weekly',
      diary_caption_level = -1,
      auto_toc = 1,
    }

    vim.g.vimwiki_list = { general, health }

    local wiki_group = vim.api.nvim_create_augroup('Wiki', { clear = true })

    -- Auto format lines on wiki files
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = wiki_dir .. "/**.md",
      command = [[g/./ normal gqq``]],
      group = wiki_group,
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = wiki_dir .. "/**.md",
      callback = function()
        vim.opt_local.syntax = 'markdown'
      end,
      group = wiki_group,
    })

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = wiki_dir .. "/**.wiki",
      callback = function()
        vim.opt_local.syntax = 'vimwiki'
      end,
      group = wiki_group,
    })

    -- no conceal on cursor
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "vimwiki",
      callback = function()
        vim.opt_local.concealcursor = 'c'
        vim.treesitter.language.register("markdown", "vimwiki")
      end,
      group = wiki_group,
    })
  end
}
