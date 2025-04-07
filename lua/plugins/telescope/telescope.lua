-- Fuzzy Finder (files, lsp, etc)
return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    version = '~0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    opts = {
      defaults = {
        layout_strategy = 'center',
        results_title = false,
        layout_config = {},
        initial_mode = 'insert',
        path_display = { truncate = 3 },
      },
      extensions = {},
    },
    config = function(_, opts)
      require('telescope').setup(opts)

      local telescope = require('telescope.builtin')
      local themes    = require('telescope.themes')
      local with_cfg  = require('util.telescope').with_cfg

      vim.keymap.set('n', '<leader>?',
        with_cfg(telescope.oldfiles, themes.get_ivy, { initial_mode = 'normal', winblend = 10 }),
        { desc = '[?] Find recently opened files' })

      vim.keymap.set('n', '<leader>/',
        with_cfg(telescope.current_buffer_fuzzy_find, themes.get_dropdown, { winblend = 10, previewer = false }),
        { desc = '[/] Fuzzily search in current buffer]' })

      vim.keymap.set('n', '<leader><space>',
        with_cfg(telescope.buffers, themes.get_ivy, { initial_mode = 'normal', winblend = 10 }),
        { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>sf',
        with_cfg(telescope.find_files, themes.get_ivy, { initial_mode = 'insert', winblend = 10 }),
        { desc = '[S]earch [F]iles' })

      vim.keymap.set('n', '<leader>sm',
        with_cfg(telescope.man_pages, themes.get_ivy, { initial_mode = 'insert', winblend = 10 }),
        { desc = '[S]earch [M]an pages' })

      vim.keymap.set('n', '<leader>sq',
        with_cfg(telescope.quickfix, themes.get_ivy, { initial_mode = 'insert', winblend = 10 }),
        { desc = '[S]earch [Q]uickfix' })

      vim.keymap.set('n', '<leader>sj', with_cfg(telescope.jumplist, themes.get_dropdown, {
          initial_mode = 'normal',
          layout_strategy = 'center',
          path_display = { truncate = 3, shorten = 1 },
          layout_config = {
            prompt_position = 'top',
            preview_cutoff = 30,
            width = 0.7,
            height = 0.4,
          },
        }),
        { desc = '[S]earch [j]umplist' })

      vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', with_cfg(telescope.grep_string, themes.get_dropdown, { initial_mode = 'normal' }),
        { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', with_cfg(telescope.live_grep, themes.get_ivy),
        { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', with_cfg(telescope.diagnostics, themes.get_ivy, {
          initial_mode = 'normal',
          root_dir = true,
        }),
        { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sk', telescope.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sc', telescope.commands, { desc = '[S]earch [C]ommands' })
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
        init = function()
          vim.g.bookmark_no_default_key_mappings = 1
          vim.g.bookmark_save_per_working_dir = 1
          vim.g.bookmark_auto_save = 1
        end,
        config = function()
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
