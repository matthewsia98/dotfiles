return {
    "glepnir/dashboard-nvim",
    enabled = false,
    event = "VimEnter",
    config = function()
        require("dashboard").setup({
            theme = "doom",
            hide = {
                tabline = false,
            },
            config = {
                header = {}, --your header
                center = {
                    {
                        icon = "  ",
                        icon_hl = "String",
                        desc = "Recent Files    ",
                        desc_hl = "String",
                        key = "r",
                        key_hl = "String",
                        action = "Telescope oldfiles",
                    },
                    {
                        icon = "  ",
                        icon_hl = "String",
                        desc = "Find File       ",
                        desc_hl = "String",
                        key = "f",
                        key_hl = "String",
                        action = "Telescope find_files find_command=rg,--hidden,--files",
                    },
                    {
                        icon = "  ",
                        icon_hl = "String",
                        desc = "File Tree       ",
                        desc_hl = "String",
                        key = "t",
                        key_hl = "String",
                        action = "Neotree toggle",
                    },
                    {
                        icon = "  ",
                        icon_hl = "String",
                        desc = "Config          ",
                        desc_hl = "String",
                        key = "c",
                        key_hl = "String",
                        action = "e ~/.config/nvim/lua/user/config.lua",
                    },
                    {
                        icon = "⚙  ",
                        icon_hl = "String",
                        desc = "Options         ",
                        desc_hl = "String",
                        key = "s",
                        key_hl = "String",
                        action = "e ~/.config/nvim/lua/user/options.lua",
                    },
                    {
                        icon = "  ",
                        icon_hl = "String",
                        desc = "Quit         ",
                        desc_hl = "String",
                        key = "q",
                        key_hl = "String",
                        action = "q!",
                    },
                },
                footer = {
                    "",
                    "",
                    string.format("%d plugins loaded", require("lazy").stats().count),
                },
            },
            preview = {
                command = "lolcat -F 0.2",
                file_path = "~/.config/nvim/ascii/doom-ascii",
                file_width = 80,
                file_height = 19,
            },
        })
    end,
}
