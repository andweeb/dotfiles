" Plugins

call plug#begin(stdpath('data') . '/plugged')

" Colorscheme
Plug 'morhetz/gruvbox'

" Aesthetics
Plug 'andweeb/presence.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'kyazdani42/nvim-web-devicons'

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
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'AckslD/nvim-revJ.lua'
Plug 'akinsho/toggleterm.nvim'
Plug 'mfussenegger/nvim-dap'

" Linting and intellisense
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Language Support plugins
Plug 'dearrrfish/vim-applescript', { 'for': 'applescript' }
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'jparise/vim-graphql', { 'for': 'graphql' }
Plug 'jxnblk/vim-mdx-js', { 'for': 'mdx' }
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
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

" Disable any unused built-in plugins
lua <<EOF
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
EOF
