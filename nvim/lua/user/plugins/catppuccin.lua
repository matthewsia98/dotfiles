local installed, catppuccin = pcall(require, "catppuccin")

if installed then
    catppuccin.setup({
        flavour = "mocha",
        background = {
            light = "frappe",
            dark = "mocha",
        },
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
            mason = true,
            mini = true,
            noice = true,
            notify = true,
            nvimtree = true,
            treesitter_context = true,
            treesitter = true,
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
                virtual_text = {
                    errors = { "bold", "italic" },
                    hints = { "bold", "italic" },
                    warnings = { "bold", "italic" },
                    information = { "bold", "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
        },
        custom_highlights = function(colors)
            return {
                Comment = { fg = colors.overlay1 },
                LineNr = { fg = colors.lavender },
                CursorLineNr = { fg = colors.lavender },
                WinSeparator = { fg = colors.text },
                TreesitterContext = { bg = colors.surface0 },
                TreesitterContextLineNumber = { bg = colors.surface0, fg = colors.lavender },
                IndentBlanklineContextChar = { fg = colors.green },
                IndentBlanklineContextStart = { sp = colors.green },
            }
        end,
    })

    vim.cmd([[colorscheme catppuccin]])
end
