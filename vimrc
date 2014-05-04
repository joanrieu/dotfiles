imap jj <Esc>
set wrap
set relativenumber
set nospell
colorscheme molokai
set background=dark

let g:airline_theme = "simple"
let g:airline#extensions#tabline#enabled = 1

let g:fugitive_git_executable = "LANGUAGE=en git"
nnoremap <silent> <leader>gl :Git l -10<CR>

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11'
