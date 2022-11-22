local installed, lualine = pcall(require, "lualine")

if installed then
    lualine.setup({
        options = {
            theme = "catppuccin",
            icons_enabled = true,
            -- powerline    
            section_separators = { left = "", right = "" },
            component_separators = { left = "❘", right = "❘" },
        },
        -- a b c                x y z
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                { "branch", separator = "" },
                { "diff", separator = "" },
                {
                    "diagnostics",
                    sources = { "nvim_workspace_diagnostic" },
                    sections = { "error", "warn", "info", "hint" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                },
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "info", "hint" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                },
            },
            lualine_c = { "filename" },
            lualine_x = {
                "encoding",
                {
                    "fileformat",
                    symbols = {
                        unix = "UNIX",
                        dos = "DOS",
                        mac = "MAC",
                    },
                },
                "filetype",
                "filesize",
            },
            lualine_y = {},
            lualine_z = {
                "progress",
                "location",
                "searchcount",
            },
        },
    })
end
