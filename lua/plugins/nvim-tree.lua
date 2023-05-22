return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  keys = {
    { '<leader>t', '<cmd>NvimTreeFocus<CR>', mode = { 'n' }, { remap = true } },
  },
  config = function()
    require("nvim-tree").setup()
  end
}
