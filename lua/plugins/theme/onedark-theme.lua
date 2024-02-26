return {
  'navarasu/onedark.nvim', -- Theme inspired by Atom
  priority = 1000,
  config = function()
    require 'onedark'.setup {
      style = 'warm'
    }
    vim.cmd 'colorscheme onedark'
  end,
  cond = false,
}
