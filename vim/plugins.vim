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
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Linting and intellisense
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/lsp-trouble.nvim'

" Language Support plugins
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }
Plug 'HerringtonDarkholme/yats.vim', {
\   'for': ['typescript', 'typescriptreact']
\ }
Plug 'pangloss/vim-javascript', {
\   'for': ['javascript', 'javascriptreact']
\ }
Plug 'MaxMEllon/vim-jsx-pretty', {
\   'for': ['javascript', 'javascriptreact']
\ }

" Funsies
Plug 'andweeb/presence.nvim'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
