local installed, noice = pcall(require, 'noice')

if installed then
    require('noice.util.hacks').enable()
    noice.setup({
        views = {
            cmdline_popup = {
                position = {
                    row = 5,
                    col = '50%',
                },
                size = {
                    width = 60,
                    height = 'auto',
                },
            },
            popupmenu = {
                relative = 'editor',
                position = {
                    row = 8,
                    col = '50%',
                },
                size = {
                    width = 60,
                    height = 10,
                },
                border = {
                    style = 'rounded',
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
                },
            },
        },
        messages = {
            enabled = false,
        },
        lsp = {
            progress = {
                enabled = false,
            },
        },
    })
end
