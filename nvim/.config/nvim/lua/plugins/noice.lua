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
                progress = { enabled = true },
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
                        row = "30%",
                        col = "50%",
                    },
                    size = {
                        width = "auto",
                        height = "auto",
                    },
                },
            },
            routes = {
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
            },
        })
    end,
}
