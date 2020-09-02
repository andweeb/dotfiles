" Mappings

let mapleader=" "

map <leader>h :noh<CR>
map <leader>pwd :echo expand('%:p')<CR>
imap cll console.log()<Esc>^f(a

" Plugin mappings
"
" (junegunn/fzf)
map <leader><leader><Tab> :FZF<ENTER>
"
" (junegunn/vim-easy-align)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"
" (fatih/vim-go)
au FileType go nmap <leader>gf <Plug>(go-def)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gr <Plug>(go-run-tab)
au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gdb <Plug>(go-doc-browser)
au FileType go nmap <leader>gdc <Plug>(go-doc)
"
" (neoclide/coc.nvim)
" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

" Error location navigation
map <leader>n :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
map <leader>p :lprevious<CR>

" Align visually selected block of Ki shortcut items
xnoremap <leader>tk
    \ :norm ^r,$F D<CR>
    \ gv:EasyAlign **/,\%([^{(]*[})]\)\@!/ {'a': 'cccll'}<CR>
    \ gv:norm ^r{A },<CR>
    \ gv:EasyAlign -}<CR>

" No arrow keys :)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
