return {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            trouble = false,
            signs = {
                add = { text = "▍" },
                change = { text = "▍" },
                delete = { text = "" },
                topdelete = { text = "" },
            },
            on_attach = function(bufnr)
                vim.g.gitsigns_attached = true

                local map = require("keymaps").map

                -- Navigation
                map("n", "]h", function()
                    if vim.wo.diff then
                        return "]h"
                    end
                    vim.schedule(function()
                        gitsigns.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Next Hunk" })
                map("n", "[h", function()
                    if vim.wo.diff then
                        return "[h"
                    end
                    vim.schedule(function()
                        gitsigns.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Previous Hunk" })

                -- Actions
                map({ "n", "v" }, "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
                map("n", "<leader>hu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage Hunk" })
                map({ "n", "v" }, "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset Hunk" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview Hunk" })

                map("n", "<leader>hS", gitsigns.stage_buffer, { buffer = bufnr, desc = "Stage Buffer" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { buffer = bufnr, desc = "Reset Buffer" })

                map("n", "<leader>hB", function()
                    gitsigns.blame_line({ full = true })
                end, { buffer = bufnr, desc = "Blame Line" })
                map(
                    "n",
                    "<leader>hb",
                    gitsigns.toggle_current_line_blame,
                    { buffer = bufnr, desc = "Toggle Line Blame" }
                )

                map("n", "<leader>hd", gitsigns.diffthis, { buffer = bufnr, desc = "Diff against index" })
                map("n", "<leader>hD", function()
                    gitsigns.diffthis("~")
                end, { buffer = bufnr, desc = "Diff against last commit" })

                map("n", "<leader>td", gitsigns.toggle_deleted, { buffer = bufnr, desc = "Toggle Deleted" })

                map("n", "<leader>hl", gitsigns.setloclist, { buffer = bufnr, desc = "Send hunks to loclist" })
                map("n", "<leader>hq", gitsigns.setqflist, { buffer = bufnr, desc = "Send hunks to qflist" })

                -- Text object
                map({ "o", "x" }, "ih", gitsigns.select_hunk, { buffer = bufnr, desc = "Git Hunk" })
            end,
        })
    end,
}
