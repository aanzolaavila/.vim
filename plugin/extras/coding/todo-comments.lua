local opts = {
  highlight = {
    before = "fg",
    keyword = "bg",
    pattern = [[.*<(KEYWORDS)\s*]],
  },

  search = {
    command = 'rg',
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--case-sensitive",
    },
    pattern = [[\b(KEYWORDS)\b]],
  }
}

local todo = require 'todo-comments'
todo.setup(opts)

vim.keymap.set( 'n', ']t', todo.jump_next, { desc = 'Next Todo comment' })
vim.keymap.set( 'n', '[t', todo.jump_prev, { desc = 'Prev Todo comment' })
vim.keymap.set( 'n', '<leader>st', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME initial_mode=normal<cr>', { desc = '[S]earch [t]odos (TODO,FIX,FIXME)' })
vim.keymap.set( 'n', '<leader>sT', '<cmd>TodoTelescope initial_mode=normal<cr>', { desc = '[S]earch all [T]odos' })
