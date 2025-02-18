return {
  {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    keys = {
      { '<leader>t',       '<cmd>NvimTreeToggle<CR>',   mode = { 'n' }, { remap = true } },
      { '<localleader>ff', '<cmd>NvimTreeFindFile<CR>', mode = { 'n' }, { remap = true } },
    },
    opts = {
      diagnostics = {
        enable = true,
        show_on_dirs = false,
      },
      modified = {
        enable = true,
      },
    },
  },
  {
    -- to edit file system as a buffer
    'stevearc/oil.nvim',
    event = "VeryLazy",
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      -- use_default_keymaps = false,
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
