local installed, db = pcall(require, "dashboard")
if installed then
    db.header_pad = 0
    db.center_pad = 0
    db.footer_pad = 1

    db.preview_file_path = "~/.config/nvim/ascii/doom-ascii"
    db.preview_command = "lolcat -F 0.2"
    db.preview_file_width = 80
    db.preview_file_height = 19

    db.custom_center = {
        {
            icon = "",
            desc = "Recent Files",
            action = "Telescope oldfiles",
            shortcut = "SPC f r",
        },
        {
            icon = "",
            desc = "Find File",
            action = "Telescope find_files find_command=rg,--hidden,--files",
            shortcut = "SPC f f",
        },
        {
            icon = "",
            desc = "File Browser",
            action = "NvimTreeToggle",
            shortcut = "SPC n t",
        },
        {
            icon = " ",
            desc = " ",
            action = " ",
            shortcut = " ",
        },
        {
            icon = "",
            desc = "~/.config/nvim/lua/user/options.lua",
            action = "e ~/.config/nvim/lua/user/options.lua",
            shortcut = " ",
        },
        {
            icon = "",
            desc = "~/.config/nvim/lua/user/plugins.lua",
            action = "e ~/.config/nvim/lua/user/plugins.lua",
            shortcut = " ",
        },
    }

    local max_icon_len = 0
    local max_desc_len = 0
    local max_shortcut_len = 0
    for _, v in pairs(db.custom_center) do
        if not v.desc:match("~/.config/nvim/") then
            local icon_len = #v.icon
            if icon_len > max_icon_len then
                max_icon_len = icon_len
            end

            local desc_len = #v.desc
            if desc_len > max_desc_len then
                max_desc_len = desc_len
            end

            local shortcut_len = #v.shortcut
            if shortcut_len > max_shortcut_len then
                max_shortcut_len = shortcut_len
            end
        end
    end

    for _, v in pairs(db.custom_center) do
        v.icon = string.format("%-" .. max_icon_len + 2 .. "s", v.icon)
        if not v.desc:match("~/.config/nvim/") then
            v.desc = string.format("%-" .. max_desc_len + 4 .. "s", v.desc)
            v.shortcut = string.format("%-" .. max_shortcut_len .. "s", v.shortcut)
        end
    end
end
