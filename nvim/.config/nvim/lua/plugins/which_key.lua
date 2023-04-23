return {
    "folke/which-key.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
        require("which-key").setup({
            window = {
                border = "rounded",
                margin = { 0, 0, 2, 0 },
            },
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 10,
                },
            },
        })
    end,
}
