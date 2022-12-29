local installed, gitsigns = pcall(require, "gitsigns")

if installed then
    gitsigns.setup({
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = "▍",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            change = {
                hl = "GitSignsChange",
                text = "▍",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
            delete = {
                hl = "GitSignsDelete",
                text = "▍",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            untracked = {
                hl = "GitSignsAdd",
                text = "▍",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "▍",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "▍",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn",
            },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = {
            enable = false,
        },
        on_attach = function()
            local gs = package.loaded.gitsigns
            local keys = require("user.keymaps")

            -- Navigation
            keys.map("n", "]h", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Next git hunk" })
            keys.map("n", "[h", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Previous git hunk" })

            -- Actions
            keys.map({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
            keys.map({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
            keys.map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
            keys.map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            keys.map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
            keys.map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
            keys.map("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end, { desc = "blame line" })
            keys.map("n", "<leader>hb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
            keys.map("n", "<leader>hd", gs.diffthis, { desc = "Diff" })
            keys.map("n", "<leader>hD", function()
                gs.diffthis("~")
            end, { desc = "Diff ~" })
            keys.map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

            -- Text object
            keys.map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Git hunk" })
        end,
    })
end
