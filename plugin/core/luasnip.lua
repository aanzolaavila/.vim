require("luasnip.loaders.from_vscode").lazy_load()

local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
}
