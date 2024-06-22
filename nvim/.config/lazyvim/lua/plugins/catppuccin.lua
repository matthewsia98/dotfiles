return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            flavour = "auto",
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
