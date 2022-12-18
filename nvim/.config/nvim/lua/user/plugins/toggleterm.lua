local installed, toggleterm = pcall(require, "toggleterm")
local M = {}

if installed then
    toggleterm.setup({
        size = function(term)
            if term.direction == "vertical" then
                return math.floor(vim.o.columns / 4)
            end
        end,
        direction = "vertical",
        shell = "/bin/zsh",
        float_opts = {
            border = "rounded",
            width = 140,
            height = 32,
            winblend = 6,
        },
    })

    local keys = require("user.keymaps")
    keys.map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
    -- keys.map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle Floating Terminal" })
    -- keys.map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle Vertical Split Terminal" })
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
        vim.cmd('TermExec go_back=0 cmd="' .. command .. '"')
    end, { desc = "Run File" })

    keys.map("v", "<leader>tr", "<Esc><cmd>lua require('user.functions').send_visual_lines_to_terminal()<CR>")
end

return M
