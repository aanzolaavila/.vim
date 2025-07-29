local opts = {
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
}

local npairs = require 'nvim-autopairs'
npairs.setup(opts)
