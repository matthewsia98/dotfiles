return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = false,
            custom_highlights = function(colors)
                return {
                    NormalFloat = { bg = colors.base },
                    StatusLine = { bg = colors.base },
                    StatusLineNC = { bg = colors.base },
                    WinSeparator = { fg = colors.text },

                    NoiceCursor = { bg = colors.text, fg = colors.base },
                    NeoTreeNormal = { bg = colors.base },
                    TroubleNormal = { bg = colors.base },
                }
            end,
            integrations = {
                cmp = true,
                dashboard = true,
                gitsigns = true,
                leap = true,
                mason = true,
                neotree = true,
                noice = true,
                notify = true,
                treesitter_context = true,
                treesitter = true,
                ts_rainbow = true,
                telescope = true,
                lsp_trouble = true,
                which_key = true,

                -- Special Integrations
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = true,
                },
                native_lsp = {
                    enabled = true,
                },
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end,
}
