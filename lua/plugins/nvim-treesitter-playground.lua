return {
  'nvim-treesitter/playground',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  build = ':TSInstall query',
  config = function()
    require('nvim-treesitter.configs').setup {
      playground = {
        enable = true,
      },
      query_linter = {
        enable = true,
      }
    }
  end
}
