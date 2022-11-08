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
                },
            },
        },
        cmdline = {
            enabled = true,
            view = 'cmdline_popup',
        },
        messages = {
            enabled = false,
            -- view = 'messages',
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
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'written',
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'changes?',
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'yank',
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'lines?',
                },
                opts = { skip = true },
            },
        },
    })
    vim.defer_fn(function()
        require('noice.util.hacks').my_fix_cmp({ row_offset = 1 })
    end, 100)
end
