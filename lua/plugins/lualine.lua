return {
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  priority = 1000,
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    -- Set lualine as statusline
    -- See `:help lualine.txt`
    require('lualine').setup {
      options = {
        globalstatus = true,
        fmt = string.lower,
        icons_enabled = true,
        theme = 'jellybeans',
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
    }
  end,
}
