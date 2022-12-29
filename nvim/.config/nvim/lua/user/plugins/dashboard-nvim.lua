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
            icon = "⚙",
            desc = "Settings",
            action = "e ~/.config/nvim/lua/user/options.lua",
            shortcut = " ",
        },
        {
            icon = "",
            desc = "Plugins",
            action = "e ~/.config/nvim/lua/user/plugins.lua",
            shortcut = " ",
        },
    }

    local max_icon_len = 0
    local max_desc_len = 0
    local max_shortcut_len = 0
    for _, v in pairs(db.custom_center) do
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

    for _, v in pairs(db.custom_center) do
        if v.desc:match("Settings") or v.desc:match("Plugins") then
            local m = math.max(#"Settings", #"Plugins")
            local icon_length = #v.icon
            local desc_length = #v.desc
            local total_max_length = max_icon_len + max_desc_len + max_shortcut_len
            local padding = total_max_length - icon_length - m
            local icon_padding, desc_padding
            if padding % 2 ~= 0 then
                icon_padding = math.floor(padding / 2)
                desc_padding = icon_padding + 1
            else
                icon_padding = padding / 2
                desc_padding = icon_padding
            end
            v.icon = string.format("%" .. icon_length + icon_padding .. "s", v.icon)
            v.desc = string.format("  %-" .. desc_length + desc_padding .. "s", v.desc)
        else
            v.icon = string.format("%-" .. max_icon_len + 2 .. "s", v.icon)
            v.desc = string.format("%-" .. max_desc_len + 4 .. "s", v.desc)
            v.shortcut = string.format("%-" .. max_shortcut_len .. "s", v.shortcut)
        end
    end
end
