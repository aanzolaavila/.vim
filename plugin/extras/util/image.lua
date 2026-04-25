local image = require('image')

image.setup({
  tmux_show_only_in_active_window = true,
  window_overlap_clear_enabled = true,
  window_overlap_clear_ft_ingore = {
    'cmp_menu', 'cmp_docs', 'notify',
  },
})
