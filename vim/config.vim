" Embedded script syntax highlighting
let g:vimsyn_embed = 'l'

" Linting and intellisense:
"
" (dense-analysis/ale)
let g:ale_sign_error = '×'
let g:ale_sign_warning = '△'
let g:ale_fixers = {
\ 	'typescript': ['eslint']
\ }
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}

" Language Support plugins:
"
" (pangloss/vim-javascript)
let javascript_enable_domhtmlcss=1
let g:javascript_plugin_flow=1
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"
" (HerringtonDarkholme/yats.vim)
let g:yats_host_keyword = 1
"
" (suan/vim-instant-markdown)
let g:instant_markdown_autostart=0

" Colorscheme
"
" (morhetz/gruvbox)
let g:gruvbox_contrast_dark="hard"
try
    let g:gruvbox_italic=1

    colorscheme gruvbox

    highlight Comment cterm=italic
    highlight Normal guibg=NONE ctermbg=NONE

catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme default
endtry

" LSP
lua package.path = package.path..";"..vim.g.srcdir.."/?.lua"
lua require("telescope")
lua require("lsp")

" Treesitter
lua <<EOF
local treesitter = require('nvim-treesitter.configs')
treesitter.setup {
    highlight = {
        enable = true,
    },
}
EOF
