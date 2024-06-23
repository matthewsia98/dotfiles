return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "auto",
            custom_highlights = function(colors)
                return {
                    NormalFloat = { link = "Normal" },
                    Pmenu = { link = "Normal" },
                    WinSeparator = { fg = colors.lavender },

                    NoiceCmdLinePopupBorder = { link = "FloatBorder" },
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
    { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
}
