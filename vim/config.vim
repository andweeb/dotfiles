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

lua package.path = package.path..";"..vim.g.srcdir.."/?.lua"

" LSP
lua require("telescope")
lua require("lsp")

" Toggleterm
lua require("term")

" Treesitter
lua <<EOF
local treesitter = require('nvim-treesitter.configs')
treesitter.setup {
    highlight = {
        enable = true,
    },
}
EOF

" Function and autocmd to update Go import block
lua <<EOF
function goimports(timeout_ms) 
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end
EOF
autocmd BufWritePre *.go lua goimports(1000)

