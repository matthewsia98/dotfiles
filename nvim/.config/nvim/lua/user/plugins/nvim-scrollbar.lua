local installed, scrollbar = pcall(require, "scrollbar")

if installed then
    local catppuccin_installed, palettes = pcall(require, "catppuccin.palettes")
    local colors, scrollbar_color
    if catppuccin_installed then
        colors = palettes.get_palette()
        scrollbar_color = colors.surface1
    end

    scrollbar.setup({
        hide_if_all_visible = false,
        show_in_active_only = true,
        handle = {
            color = scrollbar_color,
        },
        excluded_filetypes = {
            "",
            "lazy",
            "mason",
            "NvimTree",
            "TelescopePrompt",
            "lspsagafinder",
            "null-ls-info",
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
    })

    require("scrollbar.handlers.gitsigns").setup()
end
