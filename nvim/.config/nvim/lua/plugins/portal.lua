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
                border = "rounded",
            },
        })
    end,
    keys = {
        { "<leader>pj", "<CMD>Portal jumplist<CR>", desc = "" },
        { "<leader>ph", "<CMD>Portal harpoon<CR>", desc = "" },
    },
}
