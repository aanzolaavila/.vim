return {
  'ggandor/leap.nvim',
  lazy = true,
  keys = {
    { 's',         '<Plug>(leap-forward-to)',    mode = { 'n', 'x', 'o' } },
    { 'S',         '<Plug>(leap-backward-to)',   mode = { 'n', 'x', 'o' } },
    { 'gs',        '<Plug>(leap-from-window)',   mode = { 'n', 'x', 'o' } },
    { '<leader>s', '<Plug>(leap-forward-till)',  mode = { 'x', 'o' } },
    { '<leader>S', '<Plug>(leap-backward-till)', mode = { 'x', 'o' } },
  },
  config = function()
    -- require('leap').add_default_mappings()

    pcall(vim.keymap.del, { 'x', 'o' }, 'x')
    pcall(vim.keymap.del, { 'x', 'o' }, 'X')
  end
}
