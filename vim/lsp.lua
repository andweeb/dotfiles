local lspconfig = require("lspconfig")
local lsp_install_path = vim.fn.stdpath("data").."/lsp_servers"

-- Nvim DAP
local dap = require("dap")
local widgets = require("dap.ui.widgets")

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/Code/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.defaults.fallback.terminal_win_cmd = "20split new"
vim.fn.sign_define("DapBreakpoint", { text="🔴", texthl="", linehl="", numhl="" })
vim.fn.sign_define("DapBreakpointRejected", { text="❌", texthl="", linehl="", numhl="" })
vim.fn.sign_define("DapStopped", { text="👉", texthl="", linehl="", numhl="" })

vim.keymap.set("n", "<leader>d?", function() widgets.centered_float(widgets.scopes) end)
vim.keymap.set("n", "<leader>dH", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dsO", dap.step_out)
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dn", dap.run_to_cursor)
vim.keymap.set("n", "<leader>dt", dap.terminate)
vim.keymap.set("n", "<leader>dR", dap.clear_breakpoints)
vim.keymap.set("n", "<leader>de", dap.set_exception_breakpoints)
vim.keymap.set("n", "<leader>di", widgets.hover)
vim.keymap.set("n", "<leader>dk", ':lua require"dap".up()<CR>zz')
vim.keymap.set("n", "<leader>dj", ':lua require"dap".down()<CR>zz')
vim.keymap.set("n", "<leader>dr", ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

-- Setup LSP completion via nvim-cmp with luasnip
local cmp = require('cmp')
local cmpLsp = require('cmp_nvim_lsp')
local capabilities = cmpLsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({ { name = 'nvim_lsp' } }, { { name = 'buffer' } })
})

local function on_attach(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap=true, silent=true }
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
end

-- Lua
local sumneko_bin_path = lsp_install_path.."/sumneko_lua/extension/server/bin"
local server_bin = sumneko_bin_path.."/lua-language-server"
local main_lua = sumneko_bin_path.."/main.lua"
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = { server_bin, "-E", main_lua },
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "hs", "spoon", "vim" },
            },
        }
    },
}

-- Flow
lspconfig.flow.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Go
lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- TypeScript
lspconfig.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
    capabilities = capabilities,
}

-- CSS
lspconfig.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Vue
lspconfig.vuels.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- JSON
lspconfig.jsonls.setup {
    on_attach = on_attach,
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
            end
        }
    }
}
