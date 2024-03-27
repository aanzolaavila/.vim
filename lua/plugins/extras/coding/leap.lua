return {
  "ggandor/leap.nvim",
  enabled = false,
  event = "VeryLazy",
  config = function()
    require('leap').add_default_mappings()
  end
}
