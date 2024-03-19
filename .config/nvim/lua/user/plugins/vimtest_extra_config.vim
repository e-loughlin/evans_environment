" extra configuration options for Vim-Test in vim 
let g:test#preserve_screen = 1
let test#strategy = "toggleterm"

let g:test#javascript#runner = 'jest'

let g:test#javascript#jest#test_options = {
      \ 'nearest': '--coverage=False',
\}

let g:test#java#runner = 'maventest'

let test#go#runner = 'gotest'
" Runners available are 'gotest', 'ginkgo', 'richgo', 'delve'
