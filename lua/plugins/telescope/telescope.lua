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
          -- FIXME: for some reason it is not working
          vim.g.bookmark_no_default_key_mappings = 1
          -- workaround
          for _, keymap in ipairs({ 'mn', 'mp', 'ma', 'mkk', 'mjj' }) do
            vim.keymap.del('n', keymap)
          end
          -- end workaround

          vim.g.bookmark_save_per_working_dir = 1
          vim.g.bookmark_auto_save = 1

          -- default keymaps
          vim.keymap.set('n', 'mm', '<CMD>BookmarkToggle<CR>', { desc = 'Add/remove bookmark at current line' })
          vim.keymap.set('n', 'mi', '<CMD>BookmarkAnnotate<CR>', { desc = 'Add/edit/remove annotation at current line' })
          vim.keymap.set('n', 'mc', '<CMD>BookmarkClear<CR>', { desc = 'Clear bookmarks in current buffer only' })
          vim.keymap.set('n', 'mx', '<CMD>BookmarkClearAll<CR>', { desc = 'Clear bookmarks in all buffers' })
        end
      }
    },
    event = 'VeryLazy',
    config = function()
      local telescope = require('telescope')
      telescope.load_extension('vim_bookmarks')

      vim.keymap.set('n', '<leader>sb', telescope.extensions.vim_bookmarks.all,
        { desc = '[s]earch [b]ookmarks' })
      vim.keymap.set('n', '<leader>sB', telescope.extensions.vim_bookmarks.current_file,
        { desc = '[s]earch [B]ookmarks in current file' })
    end,
  }
}
