local highlight = {
    -- "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

return {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
        indent = {
            char = "▎",
            tab_char = "▎",
            highlight = highlight,
        },
        scope = { show_start = true },
    },
}
