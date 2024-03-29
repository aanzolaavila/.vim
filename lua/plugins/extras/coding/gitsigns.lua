return {
  'lewis6991/gitsigns.nvim',
  event = "VeryLazy",
  config = function()
    -- Gitsigns
    -- See `:help gitsigns.txt`
    require('gitsigns').setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    }
  end
}
