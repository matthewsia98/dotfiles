return {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    event = "BufWinEnter *.ju.py",
    config = function()
        require("jupynium").setup({
            python_host = "python3",
            firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
            firefox_profile_name = "default-release",
            use_default_keybindings = false,
        })

        local bufnr = vim.api.nvim_get_current_buf()
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
        map(
            { "n", "x" },
            "<leader>x",
            "<CMD>JupyniumExecuteSelectedCells<CR>",
            { buffer = bufnr, desc = "Execute Selected Cells" }
        )
        map(
            "n",
            "<leader>jls",
            ":JupyniumLoadFromIpynbTabAndStartSync ",
            { buffer = bufnr, desc = "Load and Sync to existing ipynb notebook" }
        )
    end,
}
