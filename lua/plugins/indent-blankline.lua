return {
  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  main = "ibl",
  config = function()
    -- See `:help ibl`

    -- Show custom characters for non-printable characters
    vim.opt.listchars = {
      eol = '↴',
      tab = '»·',
      trail = '·',
      extends = '<',
      precedes = '>',
    }

    require('ibl').setup {
      show_trailing_blankline_indent = false,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      indent_blankline_use_treesitter = true,
      indent_blankline_show_end_of_line = true,
      indent = {
        char = '┊',
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
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
}
