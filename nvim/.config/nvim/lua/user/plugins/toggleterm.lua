local installed, toggleterm = pcall(require, "toggleterm")

if installed then
    toggleterm.setup({
        size = function(term)
            if term.direction == "vertical" then
                return vim.o.columns * 0.4
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
            command = "chmod +x " .. filepath .. "; " .. prefix .. filepath
        end
        vim.cmd('TermExec cmd="' .. command .. '"')
    end, { desc = "Run File" })
    keys.map("v", "<leader>tr", function()
        local filetype = vim.bo.filetype
        local t = require('toggleterm.terminal')
        if #t.get_all() == 0 then
            t.get_or_create_term(t.get_toggled_id(), nil, nil):open(nil, nil)
            local term = t.get_all()[t.get_toggled_id()]
            local job = term.job_id
            local pid = vim.fn.jobpid(job)
            vim.g.toggleterm_pid = pid
        end

        if filetype == "python" then
            local ipython = vim.fn.system("ps -f -u $USER | grep '" .. vim.g.toggleterm_pid .. ".*[i]python --no-autoindent'")
            if ipython == "" then
                vim.cmd('TermExec cmd="ipython --no-autoindent"')
            end
        end
        local cmd = [[<Esc><cmd>lua require('toggleterm').send_lines_to_terminal('visual_lines', false, {})<CR>]]
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), "v", false)
    end, { desc = "Send Lines to Terminal" })
end
