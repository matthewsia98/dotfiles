local catppuccin = require('catppuccin')
local catppuccin_palette = require('catppuccin/palettes').get_palette()

vim.g.catppuccin_flavour = 'macchiato'
catppuccin.setup {
    transparent_background = false,
    integrations = {},
    custom_highlights = {
        Comment = { fg = catppuccin_palette.blue },
        LineNr = { fg = catppuccin_palette.lavender },
        CursorLineNr = { fg = '#00FFFF' }
    }
}
vim.cmd [[colorscheme catppuccin]]
