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

    -- My cmp fix
    local hacks = require('noice.util.hacks')
    local function my_fix_cmp(opts)
        local Util = require("noice.util")
        local Api = require("noice.api")

        if opts == nil then
            opts = {
                row_offset = 1
            }
        end

        if not Util.module_exists("cmp.utils.api") then
            -- cmp not availablle
            return
        end

        local api = require("cmp.utils.api")

        local get_cursor = api.get_cursor
        api.get_cursor = function()
            if api.is_cmdline_mode() then
            local pos = Api.get_cmdline_position()
            if pos then
                return { pos.bufpos.row, vim.fn.getcmdpos() - 1 }
            end
            end
            return get_cursor()
        end

        local get_screen_cursor = api.get_screen_cursor
        api.get_screen_cursor = function()
            if api.is_cmdline_mode() then
            local utf8 = require('lua-utf8')
            local options = require('noice.config').options
            local cmdtype = vim.fn.getcmdtype()
            local cmdline = vim.fn.getcmdline()
            local pos = Api.get_cmdline_position()
            if pos then
                local col_offset = 0
                if cmdtype == ':' then
                    col_offset = utf8.len(options.cmdline.format.cmdline.icon) - 1
                    local help_prefix_short = cmdline:match('^h%s+')
                    local help_prefix_long = cmdline:match('^help%s+')
                    if help_prefix_short or help_prefix_long then
                        local n = help_prefix_short and utf8.len(help_prefix_short) or utf8.len(help_prefix_long)
                        col_offset = utf8.len(options.cmdline.format.help.icon) + n - 1
                    end

                    local lua_prefix = cmdline:match('^lua%s+')
                    if lua_prefix then
                        col_offset = utf8.len(options.cmdline.format.lua.icon) + #lua_prefix - 1
                    end
                elseif cmdtype == '/' then
                    col_offset = utf8.len(options.cmdline.format.search_down.icon) - 1
                elseif cmdtype == '?' then
                    col_offset = utf8.len(options.cmdline.format.search_up) - 1
                end
                return { pos.screenpos.row + opts.row_offset, pos.screenpos.col + vim.fn.getcmdpos() - col_offset - 1 }
            end
            end
            return get_screen_cursor()
        end

        table.insert(hacks._disable, function()
            api.get_cursor = get_cursor
            api.get_screen_cursor = get_screen_cursor
        end)
    end

    vim.defer_fn(my_fix_cmp, 300)
end
