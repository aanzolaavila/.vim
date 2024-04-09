return {
  -- Additional text objects via treesitter
  'nvim-treesitter/playground',
  event = 'VeryLazy',
  dependencies = {
    {
      'nvim-treesitter',
      opts = {
        configs = {
          playground = {
            enable = true,
          },
          query_linter = {
            enable = true,
          }
        }
      }
    }
  },
}
