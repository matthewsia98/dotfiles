local installed, noice = pcall(require, "noice")

if installed then
    noice.setup({
        -- hacks = {
        --     cmp_popup_row_offset = 1,
        -- },
        routes = {
            -- Macro Recording
            {
                view = "notify",
                filter = {
                    event = "msg_showmode",
                },
            },
            {
                view = "mini",
                filter = {
                    event = "msg_show",
                    find = "%d+L, %d+B",
                },
            },
        },
        views = {
            mini = {
                position = {
                    row = "97%",
                    col = "100%",
                },
            },
            cmdline_popup = {
                position = {
                    row = "30%",
                    col = "50%",
                },
                size = {
                    width = "40%",
                    height = "auto",
                },
            },
            split = {
                size = {
                    height = "30%",
                },
            },
        },
        cmdline = {
            enabled = true,
            view = "cmdline_popup",
        },
        messages = {
            enabled = false,
            view = "notify",
            view_warn = "messages",
            view_error = "messages",
            view_history = "messages",
            view_search = "virtualtext",
        },
        notify = {
            enabled = true,
            view = "notify",
        },
        commands = {
            all = {
                -- options for the message history that you get with `:Noice`
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {},
            },
        },
        lsp = {
            progress = {
                enabled = true,
                view = "mini",
            },
            signature = {
                enabled = false,
            },
            hover = {
                enabled = false,
            },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
    })
end
