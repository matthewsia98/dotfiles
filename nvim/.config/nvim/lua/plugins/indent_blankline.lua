return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
        require("ibl").setup({
            indent = {
                highlight = {
                    -- "RainbowRed",
                    "RainbowYellow",
                    "RainbowBlue",
                    "RainbowOrange",
                    "RainbowGreen",
                    "RainbowViolet",
                    "RainbowCyan",
                },
            },
        })
    end,
}
