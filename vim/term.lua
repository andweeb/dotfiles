local toggleterm = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal

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
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "single",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    }
})

-- Terminal process toggle mappings keyed by command, used to:
-- * explicitly map with defined mappings
-- * override the toggle command to enable toggling out
_G.toggles = {
    ["ts-node"] = {
        mapping = "<C-t>",
    },
    node = {
        mapping = "<C-n>",
    },
    nvim = {
        mapping = "<leader>v",
    },
}

-- Set buffer-specific keymaps depending on the process
function _G.set_terminal_keymaps()
    local opts = { noremap = true, silent = true }

    -- Parse the command from buffer name
    local current_buf = vim.api.nvim_get_current_buf()
    local buf_name = vim.api.nvim_buf_get_name(current_buf)
    local cmd = buf_name:match("term://.*:(.*);.*")
    local process = _G.toggles[cmd]

    -- Override any process toggle command mappings in terminal mode to allow toggling out
    if process then
        local toggle_cmd = string.format([[<cmd>lua toggle_terminal_process("%s")<CR>]], cmd)
        vim.api.nvim_buf_set_keymap(0, "t", process.mapping, toggle_cmd, opts)
    end

    -- Allow exiting terminal mode with both leader and escape keys
    vim.api.nvim_buf_set_keymap(0, "t", "<leader><esc>", [[<C-\><C-n>]], opts)
end

-- Toggle a terminal process by the command name
function _G.toggle_terminal_process(cmd)
    local process = _G.toggles[cmd]
    if not process or not process.terminal then
        print(string.format("Unable to toggle unexpected terminal process: %s", cmd))
        return
    end

    process.terminal:toggle()
end

-- Add mappings for various terminal process toggles
for cmd, process in pairs(_G.toggles) do
    process.terminal = Terminal:new({
        cmd = cmd,
        hidden = true,
        dir = "git_dir",
        direction = "float",
    })

    local handler = string.format([[<cmd>lua toggle_terminal_process("%s")<CR>]], cmd)
    vim.api.nvim_set_keymap("n", process.mapping, handler, { noremap = true, silent = true })
end

-- Apply mappings for the terminal
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
