" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------
syntax enable
set clipboard=unnamed      " Enable clipboard sharing
set timeoutlen=300         " Set mapped sequence delay to 200ms
set relativenumber         " Relative numbers
set laststatus=0           " Don't display the status line
set formatoptions+=n       " Support for numbered/bullet lists
set ts=4 sw=4 expandtab    " 4-space tabstops & 4-space shiftwidth (indent)

" ----------------------------------------------------------------------------
" Backups (designated backup/swp folder)
" ----------------------------------------------------------------------------
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------
let mapleader=" "

" Error location navigation
map <leader>n :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
map <leader>p :lprevious<CR>

map <Space>h :noh<CR>
map <leader><leader><Tab> :FZF<ENTER>
map <Space>pwd :echo expand('%:p')<CR>
imap cll console.log()<Esc>^f(a

" No arrow keys :)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" ----------------------------------------------------------------------------
" Conditional path configurations
" ----------------------------------------------------------------------------
if has('nvim')
    let g:python_host_prog=system('printf $(which python3)')
endif
if has('w3m')
    let g:w3m#command=system('printf $(which w3m)')
endif

" ----------------------------------------------------------------------------
" Cursor Line
" ----------------------------------------------------------------------------
set cursorline
autocmd InsertEnter * highlight  CursorLine ctermbg=237
autocmd InsertLeave * highlight  CursorLine ctermbg=236

" ----------------------------------------------------------------------------
" Language-specific configurations
" ----------------------------------------------------------------------------
" (JavaScript)
let g:ale_sign_error = '×'                                " ale
let g:ale_sign_warning = '△'
let g:ale_fixers = {
\ 	'typescript': ['tslint']
\ }
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\}
let g:flow#autoclose=1                                    " vim-flow
let javascript_enable_domhtmlcss=1                        " vim-javascript
let g:javascript_plugin_flow=1
let b:javascript_fold=1                                   " vim-javascript-syntax
let g:jsx_ext_required=0                                  " mxw/vim-jsx
let g:used_javascript_libs='                              " javascript-libraries-syntax
    \ react,
    \ jquery,
    \ flux,
    \ underscore,
    \ chai'

autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" (Go)
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_structs=1
let g:go_highlight_interfaces=1
let g:go_highlight_operators=1
let g:go_highlight_build_constraints=1
let g:go_fmt_command="goimports"
au FileType go nmap <leader>gf <Plug>(go-def)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gr <Plug>(go-run-tab)
au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gdb <Plug>(go-doc-browser)
au FileType go nmap <leader>gdc <Plug>(go-doc)

" (Markdown)
let g:instant_markdown_autostart=0

" (Conf)
au BufEnter,BufRead *.conf setf dosini

" ----------------------------------------------------------------------------
" Other Configurations
" ----------------------------------------------------------------------------
" (Local config)
if !empty(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

set rtp+=/usr/local/opt/fzf                             " (FZF)
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim    " (Go)

" ----------------------------------------------------------------------------
" Plugins (vim-plug)
" ----------------------------------------------------------------------------
if !empty(glob('~/.config/nvim/autoload/plug.vim')) || !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'Shougo/vimproc.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'w0rp/ale'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'

    " (Colorschemes)
    Plug 'morhetz/gruvbox'

    " (Language syntax plugins)
    Plug 'editorconfig/editorconfig-vim'
    " (Elixir plugins)
    Plug 'elixir-lang/vim-elixir'
    Plug 'slashmili/alchemist.vim'
    " (Golang plugins)
    Plug 'fatih/vim-go'
    Plug 'nsf/gocode', {'rtp': 'nvim/'}
    " (JavaScript plugins)
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'othree/javascript-libraries-syntax.vim'
    Plug 'othree/yajs.vim'
    Plug 'flowtype/vim-flow'
    " (GraphQL plugins)
    Plug 'jparise/vim-graphql'
    " (Markdown plugins)
    Plug 'suan/vim-instant-markdown'

    call plug#end()
endif

" ----------------------------------------------------------------------------
" Colorscheme & Styles
" ----------------------------------------------------------------------------
try
    colorscheme gruvbox
    let g:gruvbox_contrast_dark="hard"
    set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry

filetype plugin indent on
