return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "auto",
            custom_highlights = function(colors)
                return {
                    NormalFloat = { link = "Normal" },
                    FloatBorder = { bg = colors.base, fg = colors.blue },
                    Pmenu = { link = "Normal" },
                    WinSeparator = { fg = colors.lavender },

                    NoiceCmdLinePopupBorder = { link = "FloatBorder" },
                    TroubleNormal = { link = "Normal" },
                }
            end,
            integrations = {
                indent_blankline = {
                    colored_indent_levels = true,
                    scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
                },
            },
        },
    },
}
