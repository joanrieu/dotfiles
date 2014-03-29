imap jj <Esc>
set wrap
set relativenumber
set nospell
colorscheme molokai

let g:airline_theme = "simple"
let g:airline#extensions#tabline#enabled = 1

let g:fugitive_git_executable = "LANGUAGE=en git"
nnoremap <silent> <leader>gl :Git l -10<CR>

let g:spf13_noninvasive_completion = 1
