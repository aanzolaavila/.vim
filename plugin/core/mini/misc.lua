require('mini.misc').setup()

vim.keymap.set('n', '<leader>z', function() MiniMisc.zoom(0) end, { desc = '[z]oom-in buffer (again to zoom-out)' })
