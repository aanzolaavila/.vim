return {
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    -- Set lualine as statusline
    -- See `:help lualine.txt`
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'jellybeans',
      },
    }
  end,
}
