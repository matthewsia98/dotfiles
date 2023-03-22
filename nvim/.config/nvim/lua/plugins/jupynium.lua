return {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    event = "BufWinEnter *.ju.py",
    dev = true,
    config = function()
        require("jupynium").setup({
            python_host = "python3",
            firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
            firefox_profile_name = "jupynium",
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

        map("n", "<leader>jls", function()
            vim.api.nvim_feedkeys(":JupyniumLoadFromIpynbTabAndStartSync ", "n", false)
        end, { buffer = bufnr, desc = "Load and Sync to existing ipynb notebook" })
    end,
}
