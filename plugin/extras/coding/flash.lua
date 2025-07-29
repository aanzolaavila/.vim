local opts = {
  modes = {
    search = {
      -- to use / and ?
      enabled = false,
    },
    char = {
      -- to disable use of ftFT motions in flash
      enabled = false,
    },
  }
}

local flash = require 'flash'
flash.setup(opts)

vim.keymap.set({'n', 'x', 'o'}, 's', flash.jump, { desc = 'Flash' })
vim.keymap.set({'n', 'x', 'o'}, 'S', flash.treesitter, { desc = 'Flash Treesitter' })
