local installed, catppuccin = pcall(require, 'catppuccin')

if installed then
    catppuccin_palette = require('catppuccin/palettes').get_palette()

    vim.g.catppuccin_flavour = 'macchiato'
    catppuccin.setup {
        transparent_background = false,
        term_colors = false,
        integrations = {
            bufferline = true,
            gitsigns = true,
            cmp = true,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
            notify = true,
            nvimtree = true,
            treesitter_context = true,
            treesitter = true,
            telescope = true,
            lsp_trouble = true,
        },
        custom_highlights = {
            Comment = { fg = catppuccin_palette.blue },
            LineNr = { fg = catppuccin_palette.lavender },
            -- CursorLineNr = { fg = '#00FFFF' },
        }
    }
    vim.cmd [[colorscheme catppuccin]]
end
