return {
  'navarasu/onedark.nvim',   -- Theme inspired by Atom
  config = function()
    require 'onedark'.setup {
      style = 'warm'
    }
    vim.cmd 'colorscheme onedark'
  end
}
