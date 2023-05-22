return {
  'natecraddock/workspaces.nvim',
  event = "VeryLazy",
  config = function()
    require('workspaces').setup({
      hooks = {
        open = function()
          require('sessions').load(nil, { silent = true })
        end
      }
    })

    pcall(require('telescope').load_extension, 'workspaces')
  end
}
