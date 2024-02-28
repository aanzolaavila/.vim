return {
  {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    keys = {
      { '<leader>t', '<cmd>NvimTreeFocus<CR>', mode = { 'n' }, { remap = true } },
    },
    config = function()
      require("nvim-tree").setup()
    end
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
