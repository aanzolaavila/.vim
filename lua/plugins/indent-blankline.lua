return {
  'lukas-reineke/indent-blankline.nvim',   -- Add indentation guides even on blank lines
  config = function()
    require 'config.indent_blankline'.setup()
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  }
}
