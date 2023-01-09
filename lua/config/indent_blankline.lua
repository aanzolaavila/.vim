local M = {}

function M.setup()
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`

  -- Show custom characters for non-printable characters
  vim.opt.listchars = {
    eol = '↴',
    tab = '»·',
    trail = '·',
    extends = '<',
    precedes = '>',
  }

  require('indent_blankline').setup {
    show_trailing_blankline_indent = false,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    indent_blankline_use_treesitter = true,
    indent_blankline_show_end_of_line = true,
  }

  -- Remove eol for vimwiki files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "vimwiki",
    callback = function()
      vim.opt_local.listchars = {
        tab = '»·',
        trail = '·',
        extends = '<',
        precedes = '>',
      }
    end
  })

end

return M
