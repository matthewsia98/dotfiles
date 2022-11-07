local installed, catppuccin = pcall(require, 'catppuccin')

if installed then
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
            gitsigns = true,
            cmp = true,
            noice = true,
            notify = true,
            nvimtree = true,
            treesitter_context = true,
            treesitter = true,
            telescope = true,
            lsp_trouble = true,
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
            -- Comment = { fg = catppuccin_palette.blue },
            LineNr = { fg = catppuccin.lavender },
            -- CursorLineNr = { fg = '#00FFFF' },
        }
    }

    vim.g.catppuccin_flavour = 'mocha'
    vim.cmd [[colorscheme catppuccin]]
end
