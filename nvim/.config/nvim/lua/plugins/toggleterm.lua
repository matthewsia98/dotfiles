return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            shade_terminals = false,
            direction = "vertical",
            size = function(term)
                if term.direction == "vertical" then
                    return math.floor(vim.o.columns / 3)
                elseif term.direction == "horizontal" then
                    return math.floor(vim.o.lines / 3)
                end
            end,
            float_opts = {
                border = "rounded",
                winblend = 0,
                width = math.floor(vim.o.columns * 0.9),
                height = math.floor(vim.o.lines * 0.9),
            },
        })

        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })

        function _lazygit_toggle()
            lazygit:toggle()
        end
    end,
    keys = {
        { "<leader>tt", "<CMD>ToggleTerm<CR>", desc = "Toggle Terminal" },
        {
            "<leader>tg",
            function()
                _lazygit_toggle()
            end,
            desc = "Toggle Lazygit",
        },
        {
            "<leader>tr",
            function()
                local filetype = vim.bo.filetype
                local relative_path = vim.fn.expand("%.")
                local head = vim.fn.expand("%:h") .. "/"
                local tail = vim.fn.expand("%:t")
                if head == "." then
                    head = "./" .. head
                end

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
                    command = string.format("javac %s && java -cp %s %s", relative_path, head, tail:gsub(".java", ""))
                elseif filetype == "c" then
                    -- C
                    local output = string.format("%s", head .. tail:gsub(".c", ""))
                    command = string.format("gcc %s -o %s && %s", relative_path, output, output)
                elseif filetype == "cpp" then
                    -- C++
                    local output = string.format("%s", head .. tail:gsub(".cpp", ""))
                    command = string.format("g++ %s -o %s && %s", relative_path, output, output)
                elseif filetype == "rust" then
                    local output = string.format("%s", head .. tail:gsub(".rs", ""))
                    command = string.format("rustc %s -o %s && %s", relative_path, output, output)
                elseif filetype == "sh" or filetype == "zsh" then
                    -- SHELL
                    local absolute_path = vim.fn.expand("%:p")
                    local perms = vim.fn.getfperm(absolute_path)
                    local is_executable = perms:sub(3, 3) == "x"
                    local chmod = is_executable and "" or string.format("chmod +x %s && ", head .. tail)
                    command = string.format("%s%s", chmod, head .. tail)
                end

                vim.cmd(string.format('TermExec go_back=0 cmd="%s"', command))

                -- vim.ui.input({
                --     prompt = "Run Command: ",
                --     default = command,
                -- }, function(input)
                --     if input ~= nil then
                --         vim.cmd(string.format('TermExec go_back=0 cmd="%s"', input))
                --     end
                -- end)
            end,
            desc = "Run File",
        },
    },
}
