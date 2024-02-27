return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  },
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    vim.keymap.set("n", "<leader>0", function() harpoon:list():append() end, { desc = "Appends buffer into harpoon list" })

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Opens harpoon 1st entry" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Opens harpoon 2nd entry" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Opens harpoon 3rd entry" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Opens harpoon 4th entry" })

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    -- vim.keymap.set("n", "<leader>9", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<leader>9", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open harpoon window" })
  end,
}
