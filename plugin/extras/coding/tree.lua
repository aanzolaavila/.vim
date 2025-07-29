require("nvim-web-devicons").setup {}

require "oil".setup({
  default_file_explorer = false,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
})

require("nvim-tree").setup({
  diagnostics = {
  	enable = true,
  	show_on_dirs = false,
  },
  modified = {
  	enable = true,
  },
})

vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<CR>', { remap = true })
vim.keymap.set('n', '<localleader>ff', '<cmd>NvimTreeFindFile<CR>', { remap = true })
