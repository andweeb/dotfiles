require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "gopls",
        "jsonls",
        "cssls",
        "astro",
    },
})

-- Nvim DAP
local dap = require("dap")
local dap_utils = require("dap.utils")
local widgets = require("dap.ui.widgets")

-- Nvim DAP UI
require("dapui").setup()

-- Processes must be running in debug/inspect mode (e.g. `--inspect` flag for node)
local function create_process_attacher(type)
    return {
        name = string.format('Attach to %s process', type),
        type = type,
        request = 'attach',
        processId = dap_utils.pick_process,
    }
end
local node_launcher = {
    name = "Launch node",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
}

dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/Code/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.configurations.javascript = {
    node_launcher,
    create_process_attacher("node2"),
}
dap.configurations.typescript = { node_launcher, create_process_attacher("node2") }

dap.defaults.fallback.terminal_win_cmd = "20split new"
vim.fn.sign_define("DapBreakpoint", { text="🔴", texthl="", linehl="", numhl="" })
vim.fn.sign_define("DapBreakpointRejected", { text="❌", texthl="", linehl="", numhl="" })
vim.fn.sign_define("DapStopped", { text="👉", texthl="", linehl="", numhl="" })

-- DAP Mappings
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>d?", function() widgets.centered_float(widgets.scopes) end)
vim.keymap.set("n", "<leader>dH", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dsO", dap.step_out)
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dn", dap.run_to_cursor)
vim.keymap.set("n", "<leader>dt", dap.terminate)
vim.keymap.set("n", "<leader>dR", dap.clear_breakpoints)
vim.keymap.set("n", "<leader>de", dap.set_exception_breakpoints)
vim.keymap.set("n", "<leader>di", widgets.hover)
vim.keymap.set("n", "<leader>dk", ':lua require("dap").up()<CR>zz')
vim.keymap.set("n", "<leader>dj", ':lua require("dap").down()<CR>zz')
vim.keymap.set("n", "<leader>dr", ':lua require("dap").repl.toggle({}, "vsplit")<CR><C-w>l')

-- DAP UI Mappings
vim.keymap.set("n", "<leader>du", ':lua require("dapui").toggle()<CR>')

-- Setup LSP completion via nvim-cmp with luasnip
local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lspconfig_defaults.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)

local lsp_install_path = vim.fn.stdpath("data").."/mason/packages"
local sumneko_bin_path = lsp_install_path.."/lua-language-server/bin"
local server_bin = sumneko_bin_path.."/lua-language-server"
local main_lua = sumneko_bin_path.."/main.lua"
vim.lsp.config('lua_ls', {
    cmd = { server_bin, "-E", main_lua },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "hs", "spoon", "vim" },
            },
        }
    },
})

vim.lsp.config('cssls', {})
vim.lsp.config('gopls', {})
vim.lsp.config('jsonls', {})
vim.lsp.config('pyright', {})
vim.lsp.config('ts_ls', {})

vim.lsp.config('astro', {
    filetypes = { 'astro', 'html' },
    root_dir = require('lspconfig.util').root_pattern('astro.config.mjs', 'package.json', '.git'),
})

-- Set up LSP keybindings when LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }

    -- Go to definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- Go to declaration
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- Go to implementation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- Go to type definition
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    -- Show references
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- Show hover documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- Show signature help
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- Rename symbol
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    -- Code action
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    -- Format buffer
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

vim.lsp.enable({
  'astro',
  'cssls',
  'gopls',
  'jsonls',
  'lua_ls',
  'pyright',
  'ts_ls',
})
