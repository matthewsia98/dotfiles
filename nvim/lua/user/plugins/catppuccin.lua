local installed, catppuccin = pcall(require, 'catppuccin')

if installed then
    local palette = require('catppuccin.palettes').get_palette()
    catppuccin.setup {
        transparent_background = false,
        term_colors = false,
        styles = {
            comments = {},
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        integrations = {
            cmp = true,
            gitsigns = true,
            leap = true,
            lsp_trouble = true,
            mason = true,
            noice = true,
            notify = true,
            nvimtree = true,
            treesitter_context = true,
            treesitter = true,
            telescope = true,
            -- which_key = true,

            -- Special Integrations
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
        },
        custom_highlights = {
            Comment = { fg = palette.overlay1 },
            LineNr = { fg = palette.lavender },
            -- CursorLineNr = { fg = palette.lavender },
        }
    }

    vim.g.catppuccin_flavour = 'mocha'
    vim.cmd [[colorscheme catppuccin]]
    vim.cmd [[ highlight WinSeparator guibg=NONE guifg=#FFFFFF ]]
end
