local M = {}

function M.setup()
  require("gopher").setup {
    commands = {
      go = "go",
      gomodifytags = "gomodifytags",
      impl = "impl",
      iferr = "iferr",
    },
  }
end

return M
