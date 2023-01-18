local installed, gitsigns = pcall(require, "gitsigns")

if installed then
    gitsigns.setup({
        -- trouble = true, -- Use trouble instead of builtin qflist and loclist (Explicitly setting to true causes trouble to not be lazy loaded)
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },

        preview_config = {
            -- Options passed to nvim_open_win
            border = "rounded",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },

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

        on_attach = function()
            local keys = require("user.keymaps")

            local wk_installed, wk = pcall(require, "which-key")
            if wk_installed then
                wk.register({
                    ["<leader>"] = {
                        h = {
                            name = "Gitsigns",
                        },
                    },
                })
            end

            -- Navigation
            keys.map("n", "]h", function()
                if vim.wo.diff then
                    return "]h"
                end
                vim.schedule(function()
                    gitsigns.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Next Hunk" })
            keys.map("n", "[h", function()
                if vim.wo.diff then
                    return "[h"
                end
                vim.schedule(function()
                    gitsigns.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Previous Hunk" })

            -- Actions
            keys.map({ "n", "v" }, "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
            keys.map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
            keys.map({ "n", "v" }, "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
            keys.map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })

            keys.map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
            keys.map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })

            keys.map("n", "<leader>hB", function()
                gitsigns.blame_line({ full = true })
            end, { desc = "Blame Line" })
            keys.map("n", "<leader>hb", gitsigns.toggle_current_line_blame, { desc = "Toggle Line Blame" })

            keys.map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff against index" })
            keys.map("n", "<leader>hD", function()
                gitsigns.diffthis("~")
            end, { desc = "Diff against last commit" })

            keys.map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

            keys.map("n", "<leader>hl", gitsigns.setloclist, { desc = "Send hunks to loclist" })
            keys.map("n", "<leader>hq", gitsigns.setqflist, { desc = "Send hunks to qflist" })

            -- Text object
            keys.map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Git Hunk" })
        end,
    })
end
