" --------------------------------------------------------------------------------------------------
" General
" --------------------------------------------------------------------------------------------------
syntax enable
set clipboard=unnamed      " Enable clipboard sharing
set timeoutlen=300         " Set mapped sequence delay to 200ms
set number relativenumber  " Relative numbers
set laststatus=0           " Don't display the status line
set formatoptions+=n       " Support for numbered/bullet lists
set ts=4 sw=4 expandtab    " 4-space tabstops & 4-space shiftwidth (indent)
set foldenable             " Enable folds
set foldmethod=marker      " Use fold markers
set foldopen-=block        " Disallow block motions from opening folds
set cmdheight=1            " Shorten the cmd height a bit

" --------------------------------------------------------------------------------------------------
" Designated backup/swp folder
" --------------------------------------------------------------------------------------------------
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" --------------------------------------------------------------------------------------------------
" Mappings
" --------------------------------------------------------------------------------------------------
let mapleader=" "

" Leader key mappings
map <leader>h :noh<CR>
map <leader><leader><Tab> :FZF<ENTER>
map <leader>pwd :echo expand('%:p')<CR>
imap cll console.log()<Esc>^f(a

" Error location navigation
map <leader>n :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>
map <leader>p :lprevious<CR>

" No arrow keys :)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" --------------------------------------------------------------------------------------------------
" Plugins (vim-plug)
" --------------------------------------------------------------------------------------------------
if !empty(glob('~/.config/nvim/autoload/plug.vim')) || !empty(glob('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')

    Plug 'w0rp/ale'
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

    " (Editor Config)
    Plug 'editorconfig/editorconfig-vim'

    " (Go)
    Plug 'fatih/vim-go'

    " (JavaScript)
    Plug 'pangloss/vim-javascript'
    Plug 'flowtype/vim-flow'
    Plug 'mxw/vim-jsx'

    " (GraphQL)
    Plug 'jparise/vim-graphql'

    " (Markdown)
    Plug 'suan/vim-instant-markdown'

    call plug#end()

    let g:ale_sign_error = '×'            " (ale)
    let g:ale_sign_warning = '△'
    let g:ale_fixers = {
    \ 	'typescript': ['tslint']
    \ }
    let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'typescript': ['tslint'],
    \}
    let g:flow#autoclose=1                " (vim-flow)
    let javascript_enable_domhtmlcss=1    " (vim-javascript)
    let g:javascript_plugin_flow=1
    let g:jsx_ext_required=0              " (mxw/vim-jsx)

    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

    " (fatih/vim-go)
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

    " (suan/vim-instant-markdown)
    let g:instant_markdown_autostart=0

    " (morhetz/gruvbox)
    try
        colorscheme gruvbox
        let g:gruvbox_contrast_dark="hard"
        set background=dark
    catch /^Vim\%((\a\+)\)\=:E185/
        colorscheme default
    endtry
endif

" Load local vimrc if it exists
if !empty(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
