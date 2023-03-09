return {
    "cbochs/portal.nvim",
    cmd = "Portal",
    config = function()
        require("portal").setup({
            escape = {
                q = true,
                ["<ESC>"] = true,
            },
            window_options = {
                relative = "editor",
                border = "rounded",
                row = 100,
                col = math.floor(vim.o.columns / 4),
                width = math.floor(vim.o.columns / 2),
                height = 8,
            },
        })
    end,
    keys = {
        { "<leader>pj", "<CMD>Portal jumplist<CR>", desc = "" },
        { "<leader>ph", "<CMD>Portal harpoon<CR>", desc = "" },
    },
}
