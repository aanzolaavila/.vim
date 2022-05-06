let g:neomake_python_pylint_maker = {
  \ 'args': [
  \ '-d', 'C0114,C0115,C0116',
  \ '-f', 'text',
  \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
  \ '-r', 'n'
  \ ],
  \ 'errorformat':
  \ '%A%f:%l:%c:%t: %m,' .
  \ '%A%f:%l: %m,' .
  \ '%A%f:(%l): %m,' .
  \ '%-Z%p^%.%#,' .
  \ '%-G%.%#',
  \ }

let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('nrwi', 500)
