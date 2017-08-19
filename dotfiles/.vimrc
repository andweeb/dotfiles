" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------
set ttyfast
syntax enable
filetype plugin indent on

set encoding=utf-8              " Displayed encoding
set clipboard=unnamed           " Enable clipboard sharing
set timeoutlen=300              " Set mapped sequence delay to 200ms
set guicursor=a:hor20-Cursor    " Set cursor as underline

" ----------------------------------------------------------------------------
" Interface
" ----------------------------------------------------------------------------
set ch=1                   " Command line height
set ruler                  " Always show cursor position
set number                 " Line numbers
set hlsearch               " Highlight all search matches
set incsearch              " Search as you type
set backspace=2            " Allow backspacing over everything in insert mode
set lazyredraw             " Set lazy redraw
set nostartofline          " Don't jump to the start of line when scrolling
set relativenumber         " Relative numbers pl0x
set laststatus=2           " Always display the status line
set mouse=a                " Enable mouse support

" ----------------------------------------------------------------------------
" Text Formatting
" ----------------------------------------------------------------------------
set smarttab               " Expand tabs to spaces
set autoindent             " Automatically indent new lines
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
let mapleader=","

" Error location navigation
map <leader>n :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
map <leader>p :lprevious<CR>

map <Space>h :noh<CR>
map ,,<Tab> :FZF<ENTER>
map <Space>pwd :echo expand('%:p')<CR>

" No arrow keys :)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

imap cll console.log()<Esc>^f(a
vmap cll yocll<Esc>p
nmap cll yiwocll<Esc>p
imap cld console.dir()<Esc>^f(a
vmap cld yocld<Esc>p
nmap cld yiwocld<Esc>p

" ----------------------------------------------------------------------------
" YouCompleteMe
" ----------------------------------------------------------------------------
let ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf=ycm_extra_conf
let g:ycm_path_to_python_interpreter=system('printf $(which python)')
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_always_populate_location_list=1
let g:ycm_allow_changing_updatetime=0
let g:ycm_complete_in_comments=1
let g:ycm_warning_symbol="▵"
let g:ycm_error_symbol="✗"
if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_semantic_triggers['elm'] = ['.']

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
" Colorscheme & Styles
" ----------------------------------------------------------------------------
try
    colorscheme gruvbox

    set background=dark
    let g:gruvbox_contrast_dark="medium"
    let g:gruvbox_italicize_comments=1
    let g:gruvbox_italicize_strings=1

catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry

" ----------------------------------------------------------------------------
" Cursor Line
" ----------------------------------------------------------------------------
set cursorline
highlight CursorLine guibg=#2d2d2d
autocmd InsertEnter * highlight  CursorLine ctermbg=237
autocmd InsertLeave * highlight  CursorLine ctermbg=236

" ----------------------------------------------------------------------------
" Airline
" ----------------------------------------------------------------------------
let g:airline_theme='zenburn'
let g:airline_powerline_fonts=1
set guifont=Source\ Code\ Pro\ for\ Powerline

" ----------------------------------------------------------------------------
" Language-specific configurations
" ----------------------------------------------------------------------------
" (Elm)
let g:elm_format_autosave = 1
let g:neoformat_enabled_elm = ['elm-format']

" (JavaScript)
let g:ale_sign_error = '×'                                " ale
let g:ale_sign_warning = '△'
let g:ale_linters = {
\   'javascript': ['eslint'],
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

    " (Add-on plugins)
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'Shougo/vimproc.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'Valloric/YouCompleteMe'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'sbdchd/neoformat'
    Plug 'romainl/vim-qf'
    Plug 'w0rp/ale'

    " (Mapping plugins)
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'

    " (Colorschemes)
    Plug 'morhetz/gruvbox'
    Plug 'flazz/vim-colorschemes'

    " (Language syntax plugins)
    Plug 'editorconfig/editorconfig-vim'
    " (Elm plugins)
    Plug 'ElmCast/elm-vim'
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
    " (TypeScript plugins)
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'leafgarland/typescript-vim'
    Plug 'Quramy/tsuquyomi'
    " (Markdown plugins)
    Plug 'suan/vim-instant-markdown'

    call plug#end()
endif

filetype plugin indent on
