local installed, scrollbar = pcall(require, "scrollbar")

if installed then
    local catppuccin = require("catppuccin.palettes").get_palette()

    scrollbar.setup({
        handle = {
            color = catppuccin.surface1,
        },
        marks = {
            Cursor = {
                -- text = "",
                text = "",
                highlight = "Normal",
            },
            Error = {
                text = { "" },
            },
            Warn = {
                text = { "" },
            },
            Info = {
                text = { "" },
            },
            Hint = {
                text = { "" },
            },
            GitAdd = {
                text = "",
            },
            GitChange = {
                text = "",
            },
            GitDelete = {
                text = "",
            }
        },
        excluded_filetypes = {
            "noice",
            "lazy",
        },
    })
end
