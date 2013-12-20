" Plugins
set nocompatible
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
" Bundle manager
Bundle 'gmarik/vundle'
" File explorer
Bundle 'scrooloose/nerdtree'
" File finder
Bundle 'kien/ctrlp.vim'
" Completion
Bundle 'Valloric/YouCompleteMe'
" Text snippets engine
Bundle 'MarcWeber/ultisnips'
" Text snippets
Bundle 'honza/vim-snippets'
" Quick (un)comment
Bundle 'scrooloose/nerdcommenter'
" Matching symbol
Bundle 'ervandew/matchem'
" HTML generator
Bundle 'rstacruz/sparkup', { 'rtp': 'vim/' }
" Syntax checking
Bundle 'scrooloose/syntastic'
" Git commands
Bundle 'tpope/vim-fugitive'
" Git repository explorer
Bundle 'gregsexton/gitv'
" Color scheme
Bundle 'molokai'
" Colored parentheses
Bundle 'kien/rainbow_parentheses.vim'

" Editor
syntax enable
filetype plugin on
let g:UltiSnips = {}
let g:UltiSnips.ExpandTrigger = '@'
let g:UltiSnips.always_use_first_snippet = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py'

" Display
set lazyredraw
set mouse=a
set laststatus=2
set scrolloff=10
colorscheme molokai
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

" Indentation
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent

" Mappings
let mapleader = ' '
imap jj <Esc>
map <Tab> <C-W>
