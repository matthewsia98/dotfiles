local cmdline_row = math.floor(vim.o.lines * 0.25)

return {
    "folke/noice.nvim",
    opts = {
        lsp = {
            documentation = {
                opts = {
                    border = { style = "rounded" },
                },
            },
        },
        views = {
            cmdline_popup = {
                position = {
                    row = cmdline_row,
                },
            },
            cmdline_popupmenu = {
                position = {
                    row = cmdline_row + 3,
                },
            },
        },
    },
}
