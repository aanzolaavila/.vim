-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Telescope keymaps are now on telescope.lua config

-- Diagnostic keymaps
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = "Goto previous diagnostic" })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = "Goto next diagnostic" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open diagnostic floating text" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

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
vim.keymap.set('n', '<C-x>', '<cmd>bn<cr>bd#<cr>', { desc = "Delete buffer", silent = true })

-- Tabs
-- Remember gt (forward) and gT (backward)
vim.keymap.set('n', '<leader>T', '<cmd>tabnew<cr>', { desc = "Create new tab" })
vim.keymap.set('n', '<leader><S-H>', '<cmd>tabm -1<cr>', { desc = "Move current tab left" })
vim.keymap.set('n', '<leader><S-L>', '<cmd>tabm +1<cr>', { desc = "Move current tab right" })

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

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- When using `/` or `?` it does not matter, it will always be forward search
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- When going through search results keep match at the center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- When going up or down also keep it at the center
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")
