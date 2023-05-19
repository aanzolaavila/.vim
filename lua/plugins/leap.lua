return {
  'ggandor/leap.nvim',
  config = function()
    require('leap').add_default_mappings()

    pcall(vim.keymap.del, { 'x', 'o' }, 'x')
    pcall(vim.keymap.del, { 'x', 'o' }, 'X')

    vim.keymap.set({ 'x', 'o' }, '<leader>s', '<Plug>(leap-forward-till)')
    vim.keymap.set({ 'x', 'o' }, '<leader>S', '<Plug>(leap-backward-till)')
  end
}
