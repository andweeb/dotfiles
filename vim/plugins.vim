" Plugins

call plug#begin(stdpath('data') . '/plugged')

Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

" (Go)
Plug 'fatih/vim-go'

" (Markdown)
Plug 'suan/vim-instant-markdown'

" (AppleScript)
Plug 'dearrrfish/vim-applescript'

" (TypeScript and TSX)
Plug 'Quramy/tsuquyomi', { 'do': 'npm -g install typescript' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'HerringtonDarkholme/yats.vim'

" (JavaScript)
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'

" (GraphQL)
Plug 'jparise/vim-graphql'

call plug#end()

" w0rp/ale
let g:ale_sign_error = '×'
let g:ale_sign_warning = '△'
let g:ale_fixers = {
\ 	'typescript': ['eslint']
\ }
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}

" pangloss/vim-javascript
let javascript_enable_domhtmlcss=1
let g:javascript_plugin_flow=1
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" fatih/vim-go
au FileType go nmap <leader>gf <Plug>(go-def)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gr <Plug>(go-run-tab)
au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gdb <Plug>(go-doc-browser)
au FileType go nmap <leader>gdc <Plug>(go-doc)

" HerringtonDarkholme/yats.vim
let g:yats_host_keyword = 1

" suan/vim-instant-markdown
let g:instant_markdown_autostart=0

" morhetz/gruvbox
try
    colorscheme gruvbox
    let g:gruvbox_contrast_dark="hard"
    set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry
