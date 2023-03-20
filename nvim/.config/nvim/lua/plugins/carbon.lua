return {
    "ellisonleao/carbon-now.nvim",
    enabled = true,
    cmd = "CarbonNow",
    config = function()
        require("carbon-now").setup({
            options = {
                theme = "night-owl",
                bg = "#121212",
                font_family = "JetBrains Mono",
                font_size = "16px",
                line_numbers = false,
            },
        })
    end,
}
