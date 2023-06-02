return {
    "kiyoon/jupynium.nvim",
    build = (vim.g.python3_host_prog or "python3"):gsub("python(%d*)", "pip%1") .. " install .",
    event = "BufWinEnter *.ju.py",
    config = function()
        require("jupynium").setup({
            python_host = vim.g.python3_host_prog or "python3",
            firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
            firefox_profile_name = "jupynium",

            use_default_keybindings = true,
            textobjects = {
                use_default_keybindings = true,
            },

            kernel_hover = {
                floating_win_opts = {
                    border = "rounded",
                },
            },
        })

        -- Set default keymaps manually because lazy loading
        local bufnr = vim.api.nvim_get_current_buf()
        local opts = require("jupynium.options").opts
        if opts.use_default_keybindings then
            require("jupynium").set_default_keymaps(bufnr)
        end
        if opts.textobjects.use_default_keybindings then
            require("jupynium.textobj").set_default_keymaps(bufnr)
        end

        local map = require("keymaps").map

        map("n", "<leader>jsa", function()
            local server_running = os.capture([[ps -ef | grep "[j]upynium"]]) ~= ""
            local notebook_url = "localhost:8888"
            local cmd = server_running and ":JupyniumAttachToServer" or ":JupyniumStartAndAttachToServer"
            vim.api.nvim_feedkeys(cmd .. " " .. notebook_url, "n", false)
        end, { buffer = bufnr, desc = "Start Jupynium Server" })

        map("n", "<leader>jss", function()
            vim.api.nvim_feedkeys(":JupyniumStartSync ", "n", false)
        end, { buffer = bufnr, desc = "Sync to ipynb notebook" })

        map("n", "<leader>jls", function()
            vim.api.nvim_feedkeys(":JupyniumLoadFromIpynbTabAndStartSync ", "n", false)
        end, { buffer = bufnr, desc = "Load and Sync to existing ipynb notebook" })
    end,
}
