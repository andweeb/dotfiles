" Mappings

let mapleader=" "

map <leader>h :noh<CR>
map <leader>pwd :echo expand('%:p')<CR>

" Make window navigation consistent everywhere
" Normal mode: use Ctrl-h/j/k/l to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Terminal mode: first jump to Normal, then move
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Quick way to leave Terminal insert-mode
tnoremap <Esc> <C-\><C-n>

" When opening terminal buffers, start in insert mode
augroup BetterTerm
  autocmd!
  autocmd TermOpen * startinsert
  " Optional: hide line numbers in terminals
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" LSP Diagnostic and ALE error navigation
map <C-n> :lua vim.diagnostic.goto_next()<CR>
map <C-p> :lua vim.diagnostic.goto_prev()<CR>
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
" (Eandrju/cellular-automaton.nvim)
nmap <leader>fml <cmd>CellularAutomaton make_it_rain<CR>
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

" Keybindings for Claude Code
nnoremap <leader>a :ClaudeCode<CR>
nnoremap <leader>af :ClaudeCodeFocus<CR>
nnoremap <leader>ar :ClaudeCode --resume<CR>
nnoremap <leader>aC :ClaudeCode --continue<CR>
nnoremap <leader>am :ClaudeCodeSelectModel<CR>
nnoremap <leader>ab :ClaudeCodeAdd %<CR>
vnoremap <leader>as :ClaudeCodeSend<CR>
nnoremap <leader>as :ClaudeCodeTreeAdd<CR>
nnoremap <leader>aa :ClaudeCodeDiffAccept<CR>
nnoremap <leader>ad :ClaudeCodeDiffDeny<CR>
