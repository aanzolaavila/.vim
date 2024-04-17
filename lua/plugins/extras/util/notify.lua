return {
  "rcarriga/nvim-notify",
  opts = {
    fps = 60,
    timeout = 2500,
    max_width = 60,
    render = "compact",
    stages = "fade",
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end
}
