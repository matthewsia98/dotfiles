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
        { "<leader>pjf", "<CMD>Portal jumplist forward<CR>", desc = "" },
        { "<leader>pjb", "<CMD>Portal jumplist backward<CR>", desc = "" },
        { "<leader>phf", "<CMD>Portal harpoon forward<CR>", desc = "" },
        { "<leader>phb", "<CMD>Portal harpoon backward<CR>", desc = "" },
    },
}
