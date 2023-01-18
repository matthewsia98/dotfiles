local installed, nvim_web_devicons = pcall(require, "nvim-web-devicons")

if installed then
    nvim_web_devicons.setup({
        -- globally enable different highlight colors per icon (default to true)
        -- if set to false all icons will have the default icon's color
        color_icons = true,

        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
    })
end
