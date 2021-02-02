local lspconfig = require("lspconfig")
local completion = require("completion")

-- Lua
local lsp_install_path = vim.fn.stdpath('cache')..'/lspconfig'
local sumneko_root_path = lsp_install_path..'/sumneko_lua/lua-language-server'
local sumneko_bin = sumneko_root_path.."/bin/macOS/lua-language-server"

lspconfig.sumneko_lua.setup {
    on_attach = completion.on_attach,
    cmd = { sumneko_bin, "-E", sumneko_root_path.."/main.lua" },
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
    on_attach = completion.on_attach,
}

-- TypeScript
lspconfig.tsserver.setup {
    on_attach = completion.on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
}
