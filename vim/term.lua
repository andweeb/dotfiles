local toggleterm = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal

-- Table of terminal program toggles
_G.TermToggles = {}

-- Setup toggleterm
toggleterm.setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'single',
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    }
})

-- Set keymaps in terminal mode
function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    -- Enter normal mode in terminal mode with leader key and escape
    vim.api.nvim_buf_set_keymap(0, 't', '<leader><esc>', [[<C-\><C-n>]], opts)
end

-- Helper function to map various terminal programs
local function map(cmd, keycode)
    local program = Terminal:new({
        cmd = cmd,
        hidden = true,
        dir = "git_dir",
        direction = "float",
    })

    _G.TermToggles[cmd] = function()
        program:toggle()
    end

    local handler = string.format([[<cmd>lua TermToggles["%s"]()<CR>]], cmd)
    vim.api.nvim_set_keymap("n", keycode, handler, { noremap = true, silent = true })
end

-- Add mappings for various terminal program toggles
map("node", "<leader><C-n>")
map("nvim", "<leader><C-v>")

-- Apply mappings for the terminal
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
