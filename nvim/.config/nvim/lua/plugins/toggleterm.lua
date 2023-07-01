local function toggleterm_run(opts)
    local filetype = vim.bo.filetype
    local cwd = vim.fn.getcwd()
    local absolute_path = vim.fn.expand("%:p")
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
        local module = vim.fn.expand("%:r"):gsub("/", ".")
        local flags = "-" .. (opts.interactive and "i" or "") .. "m"
        command = string.format("python %s %s", flags, module)
    elseif filetype == "go" then
        -- GO
        command = "go run " .. relative_path
    elseif filetype == "rust" then
        -- RUST
        local cargo_toml_dir = require("lspconfig.util").root_pattern("Cargo.toml")(absolute_path)
        if cargo_toml_dir then
            local esc_cargo_toml_dir = cargo_toml_dir:gsub("%-", "%%-")
            if cwd:match(esc_cargo_toml_dir) then
                -- cwd inside cargo project
                command = "cargo run"
            else
                command = string.format("cargo run --manifest-path %s", cargo_toml_dir .. "/Cargo.toml")
            end
        else
            local output = string.format("%s", head .. tail:gsub(".rs", ""))
            command = string.format("rustc %s -o %s && %s", relative_path, output, output)
        end
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
        local perms = vim.fn.getfperm(absolute_path)
        local is_executable = perms:sub(3, 3) == "x"
        local chmod = is_executable and "" or string.format("chmod +x %s && ", head .. tail)
        command = string.format("%s%s", chmod, head .. tail)
    end

    vim.cmd(string.format('TermExec direction=%s go_back=0 cmd="%s"', opts.direction, command))

    -- vim.ui.input({
    --     prompt = "Run Command: ",
    --     default = command,
    -- }, function(input)
    --     if input ~= nil then
    --         vim.cmd(string.format('TermExec go_back=0 cmd="%s"', input))
    --     end
    -- end)
end

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
                winblend = 10,
                width = math.floor(vim.o.columns * 0.9),
                height = math.floor(vim.o.lines * 0.9),
            },
            highlights = {
                FloatBorder = {
                    link = "FloatBorder",
                },
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
                toggleterm_run({ direction = "float" })
            end,
            desc = "Run File",
        },
        {
            "<leader>tsr",
            function()
                toggleterm_run({ direction = "horizontal" })
            end,
            desc = "Run File",
        },
        {
            "<leader>tvr",
            function()
                toggleterm_run({ direction = "vertical" })
            end,
            desc = "Run File",
        },
        {
            "<leader>tir",
            function()
                toggleterm_run({ interactive = true, direction = "float" })
            end,
            desc = "Run File",
        },
        {
            "<leader>tisr",
            function()
                toggleterm_run({ interactive = true, direction = "horizontal" })
            end,
            desc = "Run File",
        },
        {
            "<leader>tivr",
            function()
                toggleterm_run({ interactive = true, direction = "vertical" })
            end,
            desc = "Run File",
        },
    },
}
