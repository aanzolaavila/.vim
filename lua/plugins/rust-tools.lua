return {
  'simrat39/rust-tools.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim'
  },
  config = function()
    require 'config.nvim-telescope'.setup()
  end
}
