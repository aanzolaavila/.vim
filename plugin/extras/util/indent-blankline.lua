vim.opt.list = true
vim.opt.listchars = {
  eol = '↴',
  tab = '┊·',
  trail = '·',
  extends = '<',
  precedes = '>',
}

local opts = {
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

require('ibl').setup(opts)
