local toggleterm = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal

-- Global terminal toggles
Toggles = {}

-- Setup toggleterm
toggleterm.setup({
    size = 20,
    open_mapping = [[<C-\>]],
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
        },
    },
})

-- Toggle mappings keyed by command name
Toggles.hs = { mapping = "<leader><C-h>" }      --  Hammerspoon CLI
Toggles.croissant = { mapping = "<leader>c" }   --  Croissant Lua REPL
Toggles.deno = { mapping = "<leader>d" }        --  Deno REPL
Toggles.gore = { mapping = "<leader>g", }       --  Go REPL
Toggles.lua = { mapping = "<leader>l" }         --  Lua REPL
Toggles.node = { mapping = "<leader>n" }        --  Node REPL
Toggles.nvim = { mapping = "<leader>v" }        --  Neovim in Neovim :)
Toggles.python2 = { mapping = "<leader>p" }     --  Python 3 REPL
Toggles["ts-node"] = { mapping = "<leader>t" }  --  TypeScript REPL
Toggles.lazygit = { mapping = "<leader><C-l>" } --  lazygit
Toggles.grip = {                                --  Grip
    mapping = "<leader><C-g>",
    command = "grip --browser"
}

-- Create an ephemeral workspace
function Toggles.createWorkspace(dirpath, startfile, commands)
    return function(terminal)
        -- Exit if workspace is already initialized
        if terminal.initialized then
            return
        end

        -- Run commands to initialize a workspace
        local command_list = {
            "dir='%s'",
            "mkdir $dir",
            "cd $dir",
            string.format("touch %s", startfile),
        }
        for i = 1, #commands  do
            table.insert(command_list, commands[i])
        end

        -- Handle prompt functionality
        if commands.prompt then
            local prompt = commands.prompt
            local answer = vim.fn.input(prompt.text, prompt.default)
            if answer ~= "" then
                table.insert(command_list, string.format("%s %s", prompt.command, answer))
            end
        end

        -- Add newline to execute the last command
        command_list[#command_list] = command_list[#command_list]..'\n'

        local expanded_dir = vim.fn.expand(dirpath)
        local dir = string.format("%s/%s-%s", expanded_dir, os.date("%F"), os.time())
        local commands_str = table.concat(command_list, '\n'):format(dir)

        -- Send commands to job channel and close
        vim.fn.chansend(terminal.job_id, commands_str)
        terminal:close()

        -- Defer startfile edit
        vim.defer_fn(function()
            vim.cmd(string.format(":e %s/%s", dir, startfile))
        end, 500)

        -- Mark as initialized
        terminal.initialized = true
    end
end

-- Workspace toggle initialized with optional npm packages
Toggles["node-workspace"] = {
    mapping = "<leader>N",
    options = {
        cmd = "zsh",
        on_open = Toggles.createWorkspace("~/Code/playground/javascript/temp", "index.js", {
            "npm init -y",
            prompt = {
                text = "Which NPM packages should we include? ",
                default = "lodash",
                command = "npm i",
            }
        }),
    },
}
-- Workspace toggle initialized with TypeScript, ts-node, and optional npm packages
Toggles["ts-node-workspace"] = {
    mapping = "<leader>T",
    options = {
        cmd = "zsh",
        on_open = Toggles.createWorkspace("~/Code/playground/typescript/temp", "index.ts", {
            "npm init -y",
            "npx tsc --init",
            prompt = {
                text = "Which NPM packages should we include? ",
                default = "typescript ts-node lodash",
                command = "npm i",
            }
        }),
    },
}

-- Set buffer-specific keymaps depending on the process
function Toggles:set_terminal_keymaps()
    local opts = { noremap = true, silent = true }

    -- Parse the command from buffer name
    local current_buf = vim.api.nvim_get_current_buf()
    local buf_name = vim.api.nvim_buf_get_name(current_buf)
    local name = buf_name:match("term://.*:(.*);.*")
    local process = self[name]

    -- Override any process toggle command mappings in terminal mode to allow toggling out
    if process then
        local toggle_cmd = string.format([[<cmd>lua Toggles:toggle_terminal_process("%s")<CR>]], name)
        vim.api.nvim_buf_set_keymap(0, "t", process.mapping, toggle_cmd, opts)
    end

    -- Allow exiting terminal mode with both leader and escape keys
    vim.api.nvim_buf_set_keymap(0, "t", "<leader><esc>", [[<C-\><C-n>]], opts)
end

-- Toggle a terminal process by the command name
function Toggles:toggle_terminal_process(cmd)
    local process = self[cmd]
    if not process or not process.terminal then
        print(string.format("Unable to toggle unexpected terminal process: %s", cmd))
        return
    end

    process.terminal:toggle()
end

-- Add mappings for various terminal process toggles
for name, process in pairs(Toggles) do
    if type(process) == "function" then
        goto continue
    end

    local cmd = process.command or name
    local options = {
        cmd = cmd,
        hidden = true,
        dir = "git_dir",
        direction = "float",
    }
    if process.options then
        for key, option in pairs(process.options) do
            options[key] = option
        end
    end

    process.terminal = Terminal:new(options)

    local handler = string.format([[<cmd>lua Toggles:toggle_terminal_process("%s")<CR>]], name)
    vim.api.nvim_set_keymap("n", process.mapping, handler, { noremap = true, silent = true })

    ::continue::
end

-- Apply mappings for the terminal
vim.cmd("autocmd! TermOpen term://* lua Toggles:set_terminal_keymaps()")
