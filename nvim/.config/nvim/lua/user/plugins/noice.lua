local installed, noice = pcall(require, "noice")

if installed then
    noice.setup({
        -- hacks = {
        --     cmp_popup_row_offset = 1,
        -- },
        routes = {
            {
                view = "notify",
                filter = {
                    event = "msg_showmode",
                },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "%d+B written",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "before #%d+",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "fewer lines?",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "more lines?",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "lines? yank",
                },
                opts = { skip = true },
            },
        },
        views = {
            mini = {
                position = {
                    row = "90%",
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
            enabled = true,
            view = "messages",
            view_warn = "messages",
            view_error = "messages",
            view_history = "messages",
            view_search = "virtualtext",
        },
        notify = {
            enabled = true,
            view = "notify",
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
