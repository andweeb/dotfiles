" Plugins

call plug#begin(stdpath('data') . '/plugged')

" Colorscheme
Plug 'morhetz/gruvbox'

" Remap plugins
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'

" Utilities
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', {
\   'dir': '~/.fzf',
\   'do': { -> fzf#install() }
\ }

" Linting and intellisense
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {
\   'branch': 'release',
\   'for': [
\       'go', 'lua',
\       'typescript', 'typescriptreact',
\       'javascript', 'javascriptreact'
\   ]
\ }

" Language Support plugins
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }
Plug 'fatih/vim-go', {
\   'for': 'go',
\   'do': ':GoInstallBinaries'
\ }
Plug 'HerringtonDarkholme/yats.vim', {
\   'for': ['typescript', 'typescriptreact']
\ }
Plug 'pangloss/vim-javascript', {
\   'for': ['javascript', 'javascriptreact']
\ }
Plug 'MaxMEllon/vim-jsx-pretty', {
\   'for': ['javascript', 'javascriptreact']
\ }

call plug#end()
