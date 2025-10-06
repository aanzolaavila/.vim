local opts = {
  defaults = {
    color_devicons = true,
    borderchars = { "", "", "", "", "", "", "", "" },
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    results_title = false,
    layout_config = {
      height = 0.999,
      width = 0.999,
    },
    initial_mode = 'insert',
    path_display = { truncate = 3 },
    prompt_position = 'top',
  },
  extensions = {},
}

local telescope = require('telescope')
telescope.setup(opts)

local builtin   = require('telescope.builtin')
local themes    = require('telescope.themes')
local with_cfg  = require('util.telescope').with_cfg

local with_opts = function(picker, theme, custom_opts)
  local new_opts = vim.tbl_deep_extend("force", opts.defaults, custom_opts or {})
  return with_cfg(picker, theme, new_opts)
end

vim.keymap.set('n', '<leader>?',
  with_opts(builtin.oldfiles, themes.get_ivy, { initial_mode = 'normal', }),
  { desc = '[?] Find recently opened files' })

vim.keymap.set('n', '<leader>/',
  with_opts(builtin.current_buffer_fuzzy_find, themes.get_dropdown,
    {
      previewer = false,
    }),
  { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader><space>',
  with_opts(builtin.buffers, themes.get_ivy, { initial_mode = 'normal', }),
  { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>sf',
  with_opts(builtin.find_files, themes.get_ivy, { initial_mode = 'insert', }),
  { desc = '[s]earch [f]iles' })

vim.keymap.set('n', '<leader>sm',
  with_opts(builtin.man_pages, themes.get_ivy, { initial_mode = 'insert', }),
  { desc = '[s]earch [m]an pages' })

vim.keymap.set('n', '<leader>sq',
  with_opts(builtin.quickfix, themes.get_ivy, { initial_mode = 'insert', }),
  { desc = '[s]earch [q]uickfix' })

vim.keymap.set('n', '<leader>sM',
  with_opts(builtin.marks, themes.get_ivy, { initial_mode = 'normal', }),
  { desc = '[s]earch [M]arks' })

vim.keymap.set('n', '<leader>sj', with_opts(builtin.jumplist, themes.get_dropdown, {
    initial_mode = 'normal',
    layout_strategy = 'center',
    trim_text = false,
    fname_width = 60,
    path_display = { 'smart' },
    layout_config = {
      prompt_position = 'top',
      preview_cutoff = 30,
    },
  }),
  { desc = '[s]earch [j]umplist' })

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })

vim.keymap.set('n', '<leader>sw', with_opts(builtin.grep_string, themes.get_dropdown, {
    initial_mode = 'normal',
    path_display = { 'smart' },
    layout_strategy = 'center',
    layout_config = {
      preview_cutoff = 30,
    },
  }),
  { desc = '[s]earch current [w]ord' })

vim.keymap.set('n', '<leader>sg', with_opts(builtin.live_grep, themes.get_ivy),
  { desc = '[s]earch by [g]rep' })

vim.keymap.set('n', '<leader>sd', with_opts(builtin.diagnostics, themes.get_ivy, {
    initial_mode = 'normal',
    path_display = { 'smart' },
    root_dir = true,
  }),
  { desc = '[s]earch [d]iagnostics' })

vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

vim.keymap.set('n', '<leader>sc',
  with_opts(builtin.commands, themes.get_dropdown, {
    initial_mode = 'normal',
  }),
  { desc = '[s]earch [c]ommands', })

-- telescope vim-bookmarks
telescope.load_extension('vim_bookmarks')

vim.keymap.set('n', '<leader>sB', telescope.extensions.vim_bookmarks.all,
  { desc = '[s]earch [b]ookmarks' })

vim.keymap.set('n', '<leader>sr',
  with_opts(builtin.registers, themes.get_ivy, { initial_mode = 'insert', }),
  { desc = '[S]earch [R]egisters' })

vim.keymap.set('n', '<leader>sb',
  with_opts(builtin.builtin, themes.get_ivy, { initial_mode = 'normal', }),
  { desc = '[S]earch [B]uiltin' })
