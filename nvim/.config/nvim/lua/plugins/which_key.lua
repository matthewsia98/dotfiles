return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup({
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 10,
                },
            },
        })
    end,
}
