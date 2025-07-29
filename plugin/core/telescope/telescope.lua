local opts = {
  defaults = {
    layout_strategy = 'center',
    results_title = false,
    layout_config = {},
    initial_mode = 'insert',
    path_display = { truncate = 3 },
  },
  extensions = {},
}

local telescope = require('telescope')
telescope.setup(opts)

local builtin = require('telescope.builtin')
local themes    = require('telescope.themes')
local with_cfg  = require('util.telescope').with_cfg

vim.keymap.set('n', '<leader>?',
  with_cfg(builtin.oldfiles, themes.get_ivy, { initial_mode = 'normal', winblend = 10 }),
  { desc = '[?] Find recently opened files' })

vim.keymap.set('n', '<leader>/',
  with_cfg(builtin.current_buffer_fuzzy_find, themes.get_dropdown,
    {
      winblend = 10,
      previewer = false,
      layout_config = { height = 0.7, width = 0.7 },
    }),
  { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader><space>',
  with_cfg(builtin.buffers, themes.get_ivy, { initial_mode = 'normal', winblend = 10 }),
  { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>sf',
  with_cfg(builtin.find_files, themes.get_ivy, { initial_mode = 'insert', winblend = 10 }),
  { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sm',
  with_cfg(builtin.man_pages, themes.get_ivy, { initial_mode = 'insert', winblend = 10 }),
  { desc = '[S]earch [M]an pages' })

vim.keymap.set('n', '<leader>sq',
  with_cfg(builtin.quickfix, themes.get_ivy, { initial_mode = 'insert', winblend = 10 }),
  { desc = '[S]earch [Q]uickfix' })

vim.keymap.set('n', '<leader>sM',
  with_cfg(builtin.marks, themes.get_ivy, { initial_mode = 'normal', winblend = 10 }),
  { desc = '[S]earch [M]arks' })

vim.keymap.set('n', '<leader>sj', with_cfg(builtin.jumplist, themes.get_dropdown, {
    initial_mode = 'normal',
    layout_strategy = 'center',
    trim_text = false,
    fname_width = 60,
    path_display = { 'smart' },
    layout_config = {
      prompt_position = 'top',
      preview_cutoff = 30,
      width = 0.7,
      height = 0.4,
    },
  }),
  { desc = '[S]earch [j]umplist' })

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })

vim.keymap.set('n', '<leader>sw', with_cfg(builtin.grep_string, themes.get_dropdown, {
    initial_mode = 'normal',
    path_display = { 'smart' },
    layout_strategy = 'center',
    layout_config = {
      preview_cutoff = 30,
      height = 0.7,
      width = 0.7,
    },
  }),
  { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>sg', with_cfg(builtin.live_grep, themes.get_ivy),
  { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>sd', with_cfg(builtin.diagnostics, themes.get_ivy, {
    initial_mode = 'normal',
    path_display = { 'smart' },
    root_dir = true,
  }),
  { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

vim.keymap.set('n', '<leader>sc',
  with_cfg(builtin.commands, themes.get_dropdown, {
    initial_mode = 'normal',
    layout_config = { height = 0.7, width = 0.7 },
  }),
  { desc = '[S]earch [C]ommands', })

-- telescope vim-bookmarks
telescope.load_extension('vim_bookmarks')

vim.keymap.set('n', '<leader>sb', telescope.extensions.vim_bookmarks.all,
  { desc = '[s]earch [b]ookmarks' })
vim.keymap.set('n', '<leader>sB', telescope.extensions.vim_bookmarks.current_file,
  { desc = '[s]earch [B]ookmarks in current file' })
