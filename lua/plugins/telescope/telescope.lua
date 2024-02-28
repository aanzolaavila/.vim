-- Fuzzy Finder (files, lsp, etc)
return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {}
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    event = "VeryLazy",
    build = 'make',
    cond = vim.fn.executable 'make' == 1,
    config = function()
      require('telescope').load_extension('fzf')
    end
  },
}
