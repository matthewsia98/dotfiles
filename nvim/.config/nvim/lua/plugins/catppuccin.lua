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
            flavour = "mocha", -- latte | frappe | macchiato | mocha
            transparent_background = false,
            custom_highlights = function(colors)
                return {
                    NormalFloat = { link = "Normal" },
                    Pmenu = { link = "Normal" },
                    PmenuSel = { bg = colors.surface2 },

                    -- fixes black bars in statusline
                    StatusLine = { link = "Normal" },

                    CursorColumn = { bg = colors.surface2 },
                    WinSeparator = { fg = colors.text },

                    NoiceCmdlinePopupBorder = { fg = colors.blue },

                    NeoTreeNormal = { link = "Normal" },
                    TroubleNormal = { link = "Normal" },

                    TreesitterContextLineNumber = { bg = colors.mantle, fg = colors.green },
                    MiniCursorWord = { sp = colors.text, style = { "underline" } },
                }
            end,
            integrations = {
                cmp = true,
                dashboard = true,
                gitsigns = true,
                harpoon = true,
                headlines = true,
                leap = true,
                markdown = true,
                mason = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
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
