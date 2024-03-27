return {
  'Wansmer/treesj',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    {
      '<leader>m',
      function()
        require('treesj').toggle()
      end,
      desc = 'toggle node under cursor (split if one-line and join if multiline)',
    },
    {
      '<leader>M',
      function()
        require('treesj').toggle({ split = { recursive = true } })
      end,
      desc = 'toggle node under cursor (recursively)',
    },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 500,
  },
}
