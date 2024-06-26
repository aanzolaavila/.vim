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
    vim.opt.list = true
    vim.opt.listchars = {
      eol = '↴',
      tab = '┊·',
      trail = '·',
      extends = '<',
      precedes = '>',
    }

    require('ibl').setup {
      indent = {
        char = { '┊' },
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = {
        show_exact_scope = true,
        include = {
          node_type = {
            lua = {
              'return_statement',
              'table_constructor',
            }
          },
        }
      },
    }
  end
}
