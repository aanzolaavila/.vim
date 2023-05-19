return {
  'natecraddock/sessions.nvim',
  config = function()
    -- Auto sessions setup
    require("sessions").setup({
      events = { "VimLeavePre", "BufEnter" },
      session_filepath = vim.fn.stdpath 'state' .. "/sessions",
      absolute = true
    })
  end
}
