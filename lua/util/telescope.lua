local M = {}

function M.with_cfg(picker, theme, opts)
  local trim_prefix = require("util.generic").trim_prefix
  local home = vim.fn.expand("$HOME")

  local default_opts = {
    winblend = 10,
    path_display = function(_, path)
      local cwd = vim.fn.getcwd()
      path = trim_prefix(path, cwd)
      path = path:gsub(home, "~")

      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s [%s]", tail, path)
    end,
  }

  opts = vim.tbl_deep_extend("force", default_opts, opts)

  return function()
    if theme then
      picker(theme(opts))
    else
      picker(opts)
    end
  end
end

return M
