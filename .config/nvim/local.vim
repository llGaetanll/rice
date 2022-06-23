" In this file I keep system-specific vim settings
" this includes themes

"  _ __   __ _ _ __ __ _ _ __ ___  ___ 
" | '_ \ / _` | '__/ _` | '_ ` _ \/ __|
" | |_) | (_| | | | (_| | | | | | \__ \
" | .__/ \__,_|_|  \__,_|_| |_| |_|___/
" | |                                  
" |_|
"

" auto start plugin when opening markdown file (default: 0)
let g:mkdp_auto_start = 0

"  _   _                              
" | | | |                             
" | |_| |__   ___ _ __ ___   ___  ___ 
" | __| '_ \ / _ \ '_ ` _ \ / _ \/ __|
" | |_| | | |  __/ | | | | |  __/\__ \
" \___|_| |_|\___|_| |_| |_|\___||___/
"

" vim themes
let g:gruvbox_contrast_dark='light'
let g:gruvbox_contrast_light='medium'
let g:gruvbox_italic=1
let g:gruvbox_italicize_strings=1

" vim airline
let g:airline_theme='gruvbox'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

" colorscheme sonokai
" colorscheme alduin
colorscheme gruvbox
