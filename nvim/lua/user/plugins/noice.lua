local installed, noice = pcall(require, 'noice')

if installed then
    noice.setup({
        views = {
            mini = {
                position = {
                    row = '90%',
                    col = '100%',
                },
            },
        },
        cmdline = {
            enabled = false,
            view = 'cmdline',
        },
        messages = {
            enabled = false,
        },
        lsp = {
            progress = {
                enabled = true,
            },
            signature = {
                enabled = false,
            }
        },
    })
end
