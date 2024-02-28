return {
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  priority = 1000,
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    options = {
      globalstatus = true,
      fmt = string.lower,
      icons_enabled = true,
      -- theme = 'habamax', -- use default one instead
      sections = {
        lualine_a = {
          'mode',
          fmt = function(str)
            return str:sub(1, 1)
          end
        },
        lualine_b = {
          'branch',
        },
      },
    },
    extensions = {
      'nvim-tree',
      'trouble',
    },
  },
}
