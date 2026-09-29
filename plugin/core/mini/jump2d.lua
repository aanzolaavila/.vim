require('mini.jump2d').setup()

vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = 'Jump to' })
