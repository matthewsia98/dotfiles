local installed, dashboard = pcall(require, "dashboard")
if installed then
    dashboard.setup({
        theme = "doom",
        config = {
            header = {}, --your header
            center = {
                {
                    icon = "  ",
                    icon_hi = "String",
                    desc = "Recent Files        ",
                    desc_hi = "String",
                    key = "r",
                    key_hi = "String",
                    action = "Telescope oldfiles",
                },
                {
                    icon = "  ",
                    icon_hi = "String",
                    desc = "Find File           ",
                    desc_hi = "String",
                    key = "f",
                    key_hi = "String",
                    action = "Telescope find_files find_command=rg,--hidden,--files",
                },
                {
                    icon = "  ",
                    icon_hi = "String",
                    desc = "File Browser        ",
                    desc_hi = "String",
                    key = "t",
                    key_hi = "String",
                    action = "NvimTreeToggle",
                },
                {
                    icon = "⚙  ",
                    icon_hi = "String",
                    desc = "Settings            ",
                    desc_hi = "String",
                    key = "s",
                    key_hi = "String",
                    action = "e ~/.config/nvim/lua/user/options.lua",
                },
                {
                    icon = "  ",
                    icon_hi = "String",
                    desc = "Plugins             ",
                    desc_hi = "String",
                    key = "p",
                    key_hi = "String",
                    action = "e ~/.config/nvim/lua/user/plugins.lua",
                },
            },
            footer = {}, --your footer
        },
        preview = {
            command = "lolcat -F 0.2",
            file_path = "~/.config/nvim/ascii/doom-ascii",
            file_width = 80,
            file_height = 19,
        },
    })
end
