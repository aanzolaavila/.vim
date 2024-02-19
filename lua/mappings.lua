-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open diagnostic floating text" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- ###############
-- CUSTOM MAPPINGS
-- ###############

-- Clipboard mappings
vim.keymap.set({ 'n', 'v' }, '<leader>y', "\"+y", { desc = '[y]ank to system clipboard' })
vim.keymap.set('n', '<leader>Y', "\"+Y", { desc = '[y]ank to system clipboard' })

vim.keymap.set('x', '<leader>p', "\"_dP", { desc = '[P]aste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', "\"+p", { desc = '[P]aste from system clipboard' })
vim.keymap.set('n', '<leader>P', "\"+P", { desc = '[P]aste from system clipboard' })

-- Better line joining
vim.keymap.set('n', 'J', "mzJ`z", { desc = '[J]oin current line with next line' })

-- When going through search results keep match at the center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- When going up or down also keep it at the center
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Common typos
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('QA', 'qa', {})
vim.api.nvim_create_user_command('WA', 'wa', {})
vim.api.nvim_create_user_command('Wa', 'wa', {})

-- Change from one windows to another directionally
vim.keymap.set('n', '<C-h>', '<C-W><C-h>')
vim.keymap.set('n', '<C-j>', '<C-W><C-j>')
vim.keymap.set('n', '<C-k>', '<C-W><C-k>')
vim.keymap.set('n', '<C-l>', '<C-W><C-l>')

-- Create vertical and horizontal splits
vim.keymap.set('n', '<leader>h', '<cmd>vsplit<cr>')
vim.keymap.set('n', '<leader>k', '<cmd>split<cr>')
vim.keymap.set('n', '<leader>j', '<cmd>split<cr><C-W><C-J>')
vim.keymap.set('n', '<leader>l', '<cmd>vsplit<cr><C-W><C-L>')

-- Buffers
vim.keymap.set('n', 'T', '<cmd>enew<cr>', { desc = "Edit a new unedited buffer" })
--[[ vim.keymap.set('n', '<S-L>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<S-H>', '<cmd>bprev<cr>') ]]
vim.keymap.set('n', '<C-x>', '<cmd>bdelete<CR>', { desc = "Delete buffer", silent = true })

-- Tabs
-- Remember gt (forward) and gT (backward)
vim.keymap.set('n', '<leader>T', '<cmd>tabnew<cr>', { desc = "Create new tab" })
vim.keymap.set('n', '<leader><S-H>', '<cmd>tabm -1<cr>', { desc = "Go to previous tab" })
vim.keymap.set('n', '<leader><S-L>', '<cmd>tabm +1<cr>', { desc = "Go to next tab" })

-- In Visual Mode, when I press . execute it as I would run it in Normal Mode, over the selected lines
vim.keymap.set('v', '.', ':normal.<CR>')

-- Move visual selection
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- HARD MODE - Disable arrow keys in Normal mode
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')

-- Terminal emulator
-- can press <Esc> to get out of terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Newlines
vim.keymap.set('n', '<leader>]', 'o<Esc>k', { desc = "Adds new line below current" })
vim.keymap.set('n', '<leader>[', 'O<Esc>j', { desc = "Adds new line above current" })
