-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
return {
  'nvim-telescope/telescope-fzf-native.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  event = "VeryLazy",
  build = 'make',
  cond = vim.fn.executable 'make' == 1,
  config = function()
    require('telescope').load_extension('fzf')
  end
}
