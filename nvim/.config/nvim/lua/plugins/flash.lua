return {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
        require("flash").setup({})
    end,
    keys = {
        {
            "s",
            mode = { "n", "o", "x" },
            function()
                require("flash").jump()
            end,
            desc = "",
        },
        {
            "S",
            mode = { "n", "o", "x" },
            function()
                require("flash").treesitter()
            end,
            desc = "",
        },
    },
}
