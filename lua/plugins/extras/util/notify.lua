return {
  "rcarriga/nvim-notify",
  opts = {
    fps = 24,
    timeout = 100,
    max_width = 90,
    render = "wrapped-compact",
    stages = "fade",
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end
}
