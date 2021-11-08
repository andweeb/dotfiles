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
Plug 'tami5/sql.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Linting and intellisense
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/lsp-trouble.nvim'

" Language Support plugins
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }
Plug 'jxnblk/vim-mdx-js', { 'for': 'mdx' }
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
