local installed, toggleterm = pcall(require, "toggleterm")
local M = {}

if installed then
    toggleterm.setup({
        size = function(term)
            if term.direction == "vertical" then
                return math.floor(vim.o.columns / 3)
            elseif term.direction == "horizontal" then
                return math.floor(vim.o.lines / 3)
            end
        end,
        direction = "vertical",
        shell = "/bin/zsh",
        shade_terminals = false,
        float_opts = {
            border = "rounded",
            width = math.floor(vim.o.columns * 0.9),
            height = math.floor(vim.o.lines * 0.9),
        },
    })

    local keys = require("user.keymaps")

    -- keys.map("n", "<leader>tf", function()
    --     vim.cmd("ToggleTerm direction=float")
    -- end, { desc = "Toggle Floating Terminal" })

    keys.map("n", "<leader>tt", function()
        local size = math.floor(vim.o.columns / 3)
        vim.cmd("ToggleTerm direction=vertical size=" .. size)
    end, { desc = "Toggle Terminal" })

    keys.map("n", "<leader>tr", function()
        local filetype = vim.bo.filetype
        local relative_path = vim.fn.expand("%.")
        local head = vim.fn.expand("%:h") .. "/"
        local tail = vim.fn.expand("%:t")

        local command
        if filetype == "lua" then
            -- LUA
            command = "lua " .. relative_path
        elseif filetype == "python" then
            -- PYTHON
            command = "python " .. relative_path
        elseif filetype == "go" then
            -- GO
            command = "go run " .. relative_path
        elseif filetype == "java" then
            -- JAVA
            command = string.format("javac %s; java -cp %s %s", relative_path, head, tail:gsub(".java", ""))
        elseif filetype == "c" then
            -- C
            local output = string.format("%s", head .. tail:gsub(".c", ""))
            command = string.format("gcc %s -o %s; %s", relative_path, output, output)
        elseif filetype == "rust" then
            local output = string.format("%s", head .. tail:gsub(".rs", ""))
            command = string.format("rustc %s -o %s; %s", relative_path, output, output)
        elseif filetype == "sh" or filetype == "zsh" then
            -- SHELL
            local absolute_path = vim.fn.expand("%:p")
            local is_executable = require("user.functions").is_executable(absolute_path)
            local chmod = is_executable and "" or string.format("chmod +x %s; ", head .. tail)
            command = string.format("%s%s", chmod, head .. tail)
        end

        local size = math.floor(vim.o.columns / 3)
        vim.cmd("TermExec go_back=0 direction=vertical size=" .. size .. ' cmd="' .. command .. '"')
    end, { desc = "Run File" })

    keys.map("v", "<leader>tr", ":<C-U>lua require('user.functions').send_visual_lines_to_terminal()<CR>", {
        desc = "Send lines to terminal",
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
    })

    local function lazygit_toggle()
        lazygit:toggle()
    end

    keys.map("n", "<leader>tg", function()
        lazygit_toggle()
    end, { desc = "Toggle lazygit" })
end

return M
