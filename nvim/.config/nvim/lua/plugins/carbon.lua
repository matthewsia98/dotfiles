return {
    "ellisonleao/carbon-now.nvim",
    cmd = "CarbonNow",
    config = function()
        require("carbon-now").setup({
            open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open",
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
