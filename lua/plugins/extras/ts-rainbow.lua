return {
  'p00f/nvim-ts-rainbow',
  cond = false,
  event = 'VeryLazy',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter',
      opts = {
        configs = {
          rainbow = {
            enable = true,
          },
        }
      }
    }
  }
}
