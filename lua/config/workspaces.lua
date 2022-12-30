local M = {}

function M.setup()
  require('workspaces').setup({
    hooks = {
      open = function()
        require('sessions').load(nil, { silent = true })
      end
    }
  })

  pcall(require('telescope').load_extension, 'workspaces')
end

return M
