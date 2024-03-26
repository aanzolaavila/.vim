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
      local telescope = require('telescope')
      local themes = require('telescope.themes')
      telescope.setup {
        defaults = {},
        pickers = {
          find_files = {
            theme = "ivy",
          },
          lsp_references = {
            theme = "ivy",
          },
        },
        extensions = {},
      }
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
  {
    'tom-anders/telescope-vim-bookmarks.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      {
        'MattesGroeger/vim-bookmarks',
        config = function()
          vim.cmd [[
            highlight BookmarkSign ctermbg=NONE ctermfg=160
            highlight BookmarkLine ctermbg=194 ctermfg=NONE

            let g:bookmark_save_per_working_dir = 1
            let g:bookmark_auto_save = 1
          ]]
        end
      }
    },
    event = 'VeryLazy',
    config = function()
      require('telescope').load_extension('vim_bookmarks')
    end,
  }
}
