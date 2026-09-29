-- mini.cmdline
--
-- Autocomplete with customizable delay. Enhances :h cmdline-completion and manual :h 'wildchar' pressing experience. Requires Neovim>=0.11, though Neovim>=0.12 is recommended.
--
-- Autocorrect words as-you-type. Only words that must come from a fixed set of candidates (like commands and options) are autocorrected by default.
--
-- Autopeek command range as-you-type. Shows a floating window with range lines along with customizable context lines.
require('mini.cmdline').setup({
  autocomplete = {
    delay = 50,
  }
})
