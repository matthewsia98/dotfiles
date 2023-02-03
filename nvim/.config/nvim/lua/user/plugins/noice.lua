local installed, noice = pcall(require, "noice")

if installed then
    noice.setup({
        -- hacks = {
        --     cmp_popup_row_offset = 1,
        -- },
        routes = {
            -- Macro Recording
            -- {
            --     view = "notify",
            --     filter = {
            --         event = "msg_showmode",
            --     },
            --     opts = {
            --         timeout = 500,
            --     },
            -- },
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
                -- Default position sticks to lualine
                position = {
                    row = "95%",
                    col = "100%",
                },
            },
            cmdline_popup = {
                position = {
                    row = "30%",
                    col = "50%",
                },
                size = {
                    width = "auto",
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
            view = "notify",
            view_warn = "notify",
            view_error = "notify",
            view_history = "messages",
            view_search = false,
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
            documentation = {
                opts = {
                    border = { style = "rounded" },
                    position = {
                        row = 2,
                    },
                    win_options = {
                        winhighlight = {
                            NormalFloat = "Normal",
                        },
                    },
                },
            },
            signature = {
                enabled = true,
            },
            hover = {
                enabled = true,
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
