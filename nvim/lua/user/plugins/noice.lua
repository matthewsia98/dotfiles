local installed, noice = pcall(require, 'noice')

if installed then
    noice.setup({
        hacks = {
            cmp_popup_row_offset = 1,
        },
        routes = {},
        views = {
            mini = {
                position = {
                    row = '90%',
                    col = '100%',
                },
            },
            cmdline_popup = {
                position = {
                    row = '30%',
                    col = '50%',
                },
                size = {
                    width = '40%',
                    height = 'auto',
                },
            },
        },
        cmdline = {
            enabled = false,
            view = 'cmdline_popup',
        },
        messages = {
            enabled = false,
            view = 'notify',
            view_warn = 'notify',
            view_error = 'notify',
            view_history = 'messages',
            view_search = 'virtualtext',
        },
        lsp = {
            progress = {
                enabled = true,
                view = 'mini',
            },
            signature = {
                enabled = false,
            },
            hover = {
                enabled = false,
            },
        },
    })
end
