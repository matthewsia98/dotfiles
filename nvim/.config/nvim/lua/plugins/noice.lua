return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    config = function()
        require("noice").setup({
            messages = { enabled = true },
            notify = { enabled = true },
            lsp = {
                progress = { enabled = false },
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
                signature = { enabled = true },
                hover = { enabled = true },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = math.floor(vim.o.columns * 0.4),
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 11,
                        col = "50%",
                    },
                    size = {
                        width = math.floor(vim.o.columns * 0.4),
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                    },
                },
            },
            routes = {
                -- Show recording messages
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },

                -- Hide written, more/less lines, lines changed, etc messages
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        any = {
                            { find = "written" },
                            { find = "%d change" },
                            { find = "%d more lines?" },
                            { find = "%d fewer lines?" },
                            { find = "%d lines? less" },
                        },
                    },
                    opts = { skip = true },
                },
            },
        })
    end,
}
