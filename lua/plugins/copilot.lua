return {
  'github/copilot.vim',
  event = "VeryLazy",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_filetypes = {
      ["*"] = false,
      ["lua"] = false,
      ["javascript"] = true,
      ["typescript"] = true,
      ["rust"] = true,
      ["c"] = true,
      ["c#"] = true,
      ["c++"] = true,
      ["go"] = true,
      ["python"] = true,
    }
  end
}
