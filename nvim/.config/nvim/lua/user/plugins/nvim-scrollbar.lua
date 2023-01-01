local installed, scrollbar = pcall(require, "scrollbar")

if installed then
    local catppuccin_installed, palettes = pcall(require, "catppuccin.palettes")
    local colors, scrollbar_color
    if catppuccin_installed then
        colors = palettes.get_palette()
        scrollbar_color = colors.surface1
    end

    scrollbar.setup({
        handle = {
            color = scrollbar_color,
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
            },
        },
        excluded_filetypes = {
            "lazy",
            "mason",
            "NvimTree",
            "TelescopePrompt",
        },
    })
end
