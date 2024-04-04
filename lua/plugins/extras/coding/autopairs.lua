return {
  -- Autopairs
  "windwp/nvim-autopairs",
  dependencies = {
    'hrsh7th/nvim-cmp',
  },
  event = "InsertEnter",
  config = function()
    local npairs = require('nvim-autopairs')
    npairs.setup({
      check_ts = true,
      --[[ FAST WRAP
           Before        Input                    After         Note
           -----------------------------------------------------------------
           (|foobar      <M-e> then press $       (|foobar)
           (|)(foobar)   <M-e> then press q       (|(foobar))
           (|foo bar     <M-e> then press qh      (|foo) bar
           (|foo bar     <M-e> then press qH      (foo|) bar
           (|foo bar     <M-e> then press qH      (foo)| bar    if cursor_pos_before = false ]]
      fast_wrap = {},
    })

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end
}
