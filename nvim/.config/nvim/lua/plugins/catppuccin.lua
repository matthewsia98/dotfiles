-- Automatically run :CatppuccinCompile whenever catppuccin.lua is updated with an autocommand
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("Catppuccin", { clear = true }),
    pattern = "catppuccin.lua",
    command = "source <afile> | CatppuccinCompile",
})

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
                    NoiceSplit = { bg = colors.base },
                    NeoTreeNormal = { bg = colors.base },
                    TroubleNormal = { bg = colors.base },
                    WhichKeyFloat = { bg = colors.base },
                    TreesitterContextLineNumber = { bg = colors.mantle, fg = colors.green },
                }
            end,
            integrations = {
                cmp = true,
                dashboard = true,
                gitsigns = true,
                harpoon = true,
                leap = true,
                markdown = true,
                mason = true,
                neotree = true,
                noice = true,
                notify = true,
                treesitter_context = true,
                treesitter = true,
                ts_rainbow = true,
                telescope = true,
                lsp_trouble = true,
                symbols_outline = true,
                which_key = true,

                -- Special Integrations
                dap = {
                    enabled = true,
                    enabled_ui = true,
                },
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = true,
                },
                native_lsp = {
                    enabled = true,
                },
                navic = {
                    enabled = true,
                },
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end,
}
