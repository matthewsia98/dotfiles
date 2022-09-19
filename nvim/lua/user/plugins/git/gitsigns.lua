local installed, gitsigns = pcall(require, 'gitsigns')
local keys = require('user.keymaps')

if installed then
    gitsigns.setup {
        on_attach = function()
            local gs = package.loaded.gitsigns
            -- Navigation
            keys.map('n', ']h',
                function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end,
                { expr = true }
            )
            keys.map('n', '[h',
                function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end,
                { expr = true }
            )

            -- Actions
            keys.map({ 'n', 'v' }, '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
            keys.map({ 'n', 'v' }, '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
            keys.map('n', '<leader>hS', gs.stage_buffer)
            keys.map('n', '<leader>hu', gs.undo_stage_hunk)
            keys.map('n', '<leader>hR', gs.reset_buffer)
            keys.map('n', '<leader>hp', gs.preview_hunk)
            keys.map('n', '<leader>hb', function() gs.blame_line { full = true } end)
            keys.map('n', '<leader>tb', gs.toggle_current_line_blame)
            keys.map('n', '<leader>hd', gs.diffthis)
            keys.map('n', '<leader>hD', function() gs.diffthis('~') end)
            keys.map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            keys.map({ 'o', 'x' }, 'ih', '<cmd><C-U>Gitsigns select_hunk<CR>')

            -- wk.register({
            --     ['['] = {
            --         h = {
            --             function()
            --                 if vim.wo.diff then return '[c' end
            --                 vim.schedule(function() gs.prev_hunk() end)
            --                 return '<Ignore>'
            --             end, 'Previous hunk'
            --         }
            --     },
            --     [']'] = {
            --         h = {
            --             function()
            --                 if vim.wo.diff then return ']c' end
            --                 vim.schedule(function() gs.next_hunk() end)
            --                 return '<Ignore>'
            --             end, 'Next hunk'
            --         }
            --     },
            --     ['<leader>h'] = {
            --         name = '+gitsigns',
            --         s = { '<cmd>Gitsigns stage_hunk<CR>', 'Stage hunk', mode = 'n' },
            --         r = { '<cmd>Gitsigns reset_hunk<CR>', 'Reset hunk', mode = 'n' },
            --         S = { gs.stage_buffer, 'Stage buffer' },
            --         u = { gs.undo_stage_hunk, 'Undo stage hunk' },
            --         R = { gs.reset_buffer, 'Reset buffer' },
            --         p = { gs.preview_hunk, 'Preview hunk' },
            --         b = { function() gs.blame_line { full = true } end, 'Blame line' },
            --         d = { gs.diffthis, 'Diff' },
            --         D = { function() gs.diffthis('~') end, 'Diff ~' },
            --         td = { gs.toggle_deleted, 'Toggle deleted' },
            --     },
            -- })
            -- wk.register({
            --     ['<leader>h'] = {
            --         name = '+gitsigns',
            --         s = { '<cmd>Gitsigns stage_hunk<CR>', 'Stage hunk', mode = 'v' },
            --         r = { '<cmd>Gitsigns reset_hunk<CR>', 'Reset hunk', mode = 'v' },
            --     }
            -- }, { mode = 'v' })
            -- wk.register({
            --     ['ih'] = { '<cmd><C-U>Gitsigns select_hunk<CR>', 'Git hunk', mode = 'o' },
            -- }, { mode = 'o' })
            -- wk.register({
            --     ['ih'] = { '<cmd><C-U>Gitsigns select_hunk<CR>', 'Git hunk', mode = 'x' },
            -- }, { mode = 'x' })
        end,
        signs = {
            add = {
                hl = 'GitSignsAdd',
                text = '▎',
                numhl = 'GitSignsAddNr',
                linehl = 'GitSignsAddLn'
            },
            change = {
                hl = 'GitSignsChange',
                text = '▎',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn'
            },
            delete = {
                hl = 'GitSignsDelete',
                text = '',
                numhl = 'GitSignsDeleteNr',
                linehl = 'GitSignsDeleteLn'
            },
            topdelete = {
                hl = 'GitSignsDelete',
                text = '',
                numhl = 'GitSignsDeleteNr',
                linehl = 'GitSignsDeleteLn'
            },
            changedelete = {
                hl = 'GitSignsChange',
                text = '~',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn'
            },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        yadm = {
            enable = false
        },
    }
end
