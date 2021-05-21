"           ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"           ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"           ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
"           ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"           ██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
"           ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
"

" install vim plugged if not already on the system
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
	Plug 'benmills/vimux' " tmux integration
	Plug 'tpope/vim-repeat' " repeat plugins
	Plug 'tpope/vim-endwise' " adds end, endif automatically
	Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)

	" Language Specific plugins
	Plug 'ap/vim-css-color' " preview colors while editing
	Plug 'MaxMEllon/vim-jsx-pretty' " JSX syntax highlighting 
	Plug 'chemzqm/vim-jsx-improve' " JSX language support
	Plug 'pangloss/vim-javascript' " JS syntax highlighting
	Plug 'jparise/vim-graphql' " GQL syntax highlighting
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " Markdown previewer
	
	" Theming - for theme settings see local.vim
	Plug 'sainnhe/sonokai' 
	Plug 'AlessandroYorba/Alduin'
	Plug 'morhetz/gruvbox'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	
	" Appearance {{{
		" For more info about any of these `:help set`
		
		" dark theme by default
		set bg=dark

		" relative line numbers on the side	
		set number
		" wrap lines (wrap/nowrap)
		set wrap
		" Number of characters from the right window border where wrapping starts
		set wrapmargin=8
		" show matching closing bracket (showmatch/noshowmatch)
		set showmatch

		" I dont understand this one
		set smarttab
		" use spaces instead of tabs
		set expandtab 
		set tabstop=4
		set softtabstop=4
		set shiftwidth=4
		set shiftround

		" fix broken colors on certain colorschemes
		set termguicolors
	" }}}
	
	" General Mappings {{{
		" leader key
		let mapleader = ","

		" remap <esc> to clear highlighting
		nnoremap <silent> <esc> :noh<return><esc>
		
		" in normal mode, Y copies to the end of the line
		nnoremap Y y$

		" in normal mode, Q breaks up a long line of text
		nnoremap Q gq
		
		" in visual mode, <ctrl> + y copies to the system clipboard
		vnoremap <C-y> "+y

		" in visual mode, ",',(,{,[ wraps the selection in quotes
		vnoremap " c""<esc>Pgvll
		vnoremap ' c''<esc>Pgvll
		vnoremap ( c()<esc>Pgvll
		vnoremap { c{}<esc>Pgvll
		vnoremap [ c[]<esc>Pgvll

		" code folding settings
		set foldmethod=indent
		set foldlevelstart=99
		set foldnestmax=3 " deepest fold is 10 levels
		set nofoldenable " don't fold by default
		set foldlevel=1

		" keep visual selection when indenting/outdenting
		vmap < <gv
		vmap > >gv
	" }}}
	
	" Tabs - All prefixed by <Tab> {{{
		" rotate between tabs: previous and next
		nnoremap <Tab>n gt
		nnoremap <Tab>N gT

		" Tab + a to open a new tab
		nnoremap <silent> <Tab>a :tabnew<CR>

		" Tab + h/l to move a tab left/right
		nnoremap <silent> <Tab>h :tabmove -<CR>
		nnoremap <silent> <Tab>l :tabmove +<CR>

		" Tab + t to move the current window to a new tab
		" note that this can also be done with `ctrl+w T`
		nnoremap <silent> <Tab>t :tabedit %<CR>
	" }}}
	
	" Windows - All prefixed by ctrl + w {
		" ctrl + w  ctrl + h/j/k/l to resize windows
		nnoremap <silent> <C-w><C-h> 5:wincmd <<CR>
		nnoremap <silent> <C-w><C-j> 5:wincmd -<CR>
		nnoremap <silent> <C-w><C-k> 5:wincmd +<CR>
		nnoremap <silent> <C-w><C-l> 5:wincmd ><CR>
	" }

	" FuzzyFind - Find files from anywhere {{{
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
		Plug 'junegunn/fzf.vim'

		" ctrl + p to fuzzy find git files
		nnoremap <silent> <C-p> :GFiles<CR>
		" ctrl + shift + p to fuzzy find all files
		nnoremap <silent> <C-P> :Files<CR>

		command! -bang -nargs=* GGrep
			\ call fzf#vim#grep(
			\   'git grep --line-number -- '.shellescape(<q-args>), 0,
			\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
	" }}}
		
	" NERDTree - Side menu like vscode {{{
		Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
		Plug 'Xuyuanp/nerdtree-git-plugin'
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
		Plug 'ryanoasis/vim-devicons'

		" <Leader> + n toggles NERDTree
		nmap <silent><C-n> :NERDTreeToggle<CR> 

		" <Leader> + shift + n focuses NERDTree from any window
		" nmap <silent><C-> :NERDTreeFocus<CR> 

		" ignore node_modules
		let g:NERDTreeIgnore = ['^node_modules$']

		" Automaticaly close nvim if NERDTree is only thing left open
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

		" Sync open file with NERDTree {
			" Check if NERDTree is open or active
			function! IsNERDTreeOpen()        
				return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
			endfunction

			" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
			" file, and we're not in vimdiff
			function! SyncTree()
				if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
					NERDTreeFind
					wincmd p
				endif
			endfunction

			" Highlight currently open buffer in NERDTree
			" autocmd BufEnter * call SyncTree()
		" }
	" }}}

	" NERDCommenter {{{
		Plug 'scrooloose/nerdcommenter' " easy commenting in vim
		filetype plugin on " changes comments based on filetype
		let g:NERDSpaceDelims			= 1
		let g:NERDCustomDelimiters		= { 'c': { 'left': '/* ','right': ' */' } }
		let g:NERDToggleCheckAllLines	= 1

		" Toggle Commenting - ctrl + /
		" Insert: 
		inoremap <C-_> <ESC>:call NERDComment(0, "toggle")<CR>li
		" Normal: 
		nnoremap <C-_> :call NERDComment(0, "toggle")<CR>
		" Visual: keeps you in visual mode
		vnoremap <C-_> :call NERDComment(0, "toggle")<CR>gv
	" }}}

	" Conquer of Completion - Autocomplete everything {{{
		Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion

		let g:coc_global_extensions = [
			\ 'coc-snippets', 
			\ 'coc-pairs',
			\ 'coc-tsserver', 
			\ 'coc-json',
			\ 'coc-go',
			\ 'coc-prettier',
			\ 'coc-rls',
			\ 'coc-clangd',
		\ ]

		set hidden " TextEdit might fail if hidden is not set.
		" Some servers have issues with backup files, see #649.
		" set nobackup
		" set nowritebackup
		
		" prettier command for coc
		command! -nargs=0 Prettier :CocCommand prettier.formatFile
		" run on save
		let g:prettier#autoformat = 1
		autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

		set cmdheight=2 " Give more space for displaying messages.
		set updatetime=300 " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.

		" Use K to show documentation in preview window.
		nnoremap <silent> K :call <SID>show_documentation()<CR>
	
		" Remap <C-j> and <C-k> for scroll float windows/popups.
		if has('nvim-0.4.0') || has('patch-8.2.0750')
			nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
			nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
		endif

		function! s:show_documentation()
			if (index(['vim','help'], &filetype) >= 0)
				execute 'h '.expand('<cword>')
			else
				call CocAction('doHover')
			endif
		endfunction
		
		" use <tab> for trigger completion and navigate to the next complete item
		function! s:check_back_space() abort
		    let col = col('.') - 1
		    return !col || getline('.')[col - 1]  =~ '\s'
		endfunction

		inoremap <silent><expr> <Tab>
		    \ pumvisible() ? "\<C-n>" :
		    \ <SID>check_back_space() ? "\<Tab>" :
		    \ coc#refresh()

		" ctrl + <space> triggers autocompletion
		inoremap <silent><expr> <c-space> coc#refresh()

		" Highlight the symbol and its references when holding the cursor.
		autocmd CursorHold * silent call CocActionAsync('highlight')
		
		" Rename all instances with F2
		nmap <F2> <Plug>(coc-rename)

		" Formatting selected code.
		xmap <leader>f  <Plug>(coc-format-selected)
		nmap <leader>f  <Plug>(coc-format-selected)

		" comment highlighting in json	
		autocmd FileType json syntax match Comment +\/\/.\+$+
	" }}}
	
	" Git Gutter - Displays changes in git-tracked files {{{
		Plug 'airblade/vim-gitgutter' " add git to file to show diffs
	
		" update gutters faster
		set updatetime=100 

		" change gutter color
		highlight GitGutterAdd    guifg=#009900 ctermfg=2
		highlight GitGutterChange guifg=#bbbb00 ctermfg=3
		highlight GitGutterDelete guifg=#ff2222 ctermfg=1

		" make gutter column invisible
		highlight! link SignColumn LineNr

		" remap gutter keybinds
		" <leader> + g + n -> next change
		nmap <leader>gn <Plug>(GitGutterNextHunk)
		" <leader> + g + p -> prev change
		nmap <leader>gp <Plug>(GitGutterPrevHunk)
		" <leader> + g + z -> fold and leave only changes
		nmap <leader>gz :GitGutterFold<CR>

		" customize gutter symbols
		let g:gitgutter_sign_added = '+'
		let g:gitgutter_sign_modified = '~'
		let g:gitgutter_sign_removed = '_'
		let g:gitgutter_sign_removed_first_line = '⌃'
		let g:gitgutter_sign_modified_removed = '⌄'
	" }}}
	
	" Markdown Preview {{{
		" auto start plugin when opening markdown file (default: 0)
		" see local.vim
		
		" <Leader> + m + p toggles markdown preview
		nmap <leader>mp <Plug>MarkdownPreviewToggle

		" auto close document when switching to another file (default: 1)
		let g:mkdp_auto_close = 0
	" }}}
	 
call plug#end()

" the following file contains device-specific vim settings.
" it should be ignore by git so feel free to change any 
" parameters there
if filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/local.vim"'))
	source ~/.config/nvim/local.vim
endif

