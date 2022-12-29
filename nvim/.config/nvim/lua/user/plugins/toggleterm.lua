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

    keys.map("n", "<leader>tt", function()
        local num_wins = #vim.api.nvim_list_wins()
        local size = math.floor(vim.o.columns / (num_wins + 1))
        vim.cmd("ToggleTerm direction=vertical size=" .. size)
    end, { desc = "Toggle Terminal" })

    keys.map("n", "<leader>tr", function()
        local filetype = vim.bo.filetype
        local filepath = vim.fn.expand("%")
        local command
        if filetype == "lua" then
            command = "lua " .. filepath
        elseif filetype == "python" then
            command = "python " .. filepath
        elseif filetype == "java" then
            local splits = vim.split(filepath, "/")
            local prefix = ""
            for i = 1, #splits - 1 do
                prefix = prefix .. splits[i] .. "/"
            end
            command = "javac " .. filepath .. "; java -cp " .. prefix .. " " .. splits[#splits]:gsub(".java", "")
        elseif filetype == "sh" or filetype == "zsh" then
            local splits = vim.split(filepath, "/")
            local prefix = #splits == 1 and "./" or ""
            local is_executable = require("user.functions").is_executable(filepath)
            local chmod = is_executable and "" or "chmod u+x " .. filepath .. "; "
            command = chmod .. prefix .. filepath
        end

        local num_wins = #vim.api.nvim_list_wins()
        local size = math.floor(vim.o.columns / (num_wins + 1))
        vim.cmd("TermExec go_back=0 direction=vertical size=" .. size .. ' cmd="' .. command .. '"')
    end, { desc = "Run File" })

    keys.map("v", "<leader>tr", "<Esc><cmd>lua require('user.functions').send_visual_lines_to_terminal()<CR>", {
        desc = "Send lines to terminal" }
    )

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
