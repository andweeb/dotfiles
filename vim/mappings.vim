" Mappings

let mapleader=" "

map <leader>h :noh<CR>
map <leader>pwd :echo expand('%:p')<CR>

" LSP Diagnostic and ALE error navigation
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
map <C-j> :lua vim.diagnostic.goto_next()<CR>
map <C-k> :lua vim.diagnostic.goto_prev()<CR>
map <leader>at :ALEToggle<CR>

" No arrow keys :)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Plugin mappings
"
" (nvim-lua/completion-nvim)
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" (nvim-telescope/telescope.nvim)
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fF <cmd>lua require('telescope').extensions.frecency.frecency()<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fB <cmd>Telescope git_branches<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>
nnoremap <leader>fs <cmd>Telescope git_status<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
"
" (fatih/vim-go)
au FileType go nmap <leader>gf <Plug>(go-def)
au FileType go nmap <leader>gi <Plug>(go-info)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gr <Plug>(go-run-tab)
au FileType go nmap <leader>gs <Plug>(go-implements)
au FileType go nmap <leader>gdb <Plug>(go-doc-browser)
au FileType go nmap <leader>gdc <Plug>(go-doc)
"
" (junegunn/vim-easy-align)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" Align visually selected block of Ki shortcut items
xnoremap <leader>tk
    \ :norm ^r,$F D<CR>
    \ gv:EasyAlign **/,\%([^{(]*[})]\)\@!/ {'a': 'cllll' }<CR>
    \ gv:norm ^r{A },<CR>
    \ gv:EasyAlign -}<CR>
