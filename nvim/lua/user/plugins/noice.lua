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
            cmdline_popup = {
                position = {
                    row = '30%',
                    col = '50%',
                },
                size = {
                    width = '40%',
                    height = 'auto',
                }
            },
        },
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    find = 'more lines?',
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    find = 'fewer lines?',
                },
                opts = { skip = true },
            },
        },
        cmdline = {
            enabled = true,
            view = 'cmdline_popup',
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
    vim.defer_fn(function()
        require('noice.util.hacks').my_fix_cmp({ row_offset = 1 })
    end, 100)
end
