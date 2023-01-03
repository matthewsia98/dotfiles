local installed, trouble = pcall(require, "trouble")

if installed then
    trouble.setup({
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- 'document_diagnostics', 'quickfix', 'lsp_references', 'loclist'
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = false, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = { "<CR>", "<Tab>" }, -- jump to the diagnostic or open / close folds
            open_split = { "<C-s>" }, -- open buffer in new split
            open_vsplit = { "<C-v>" }, -- open buffer in new vsplit
            open_tab = { "<C-t>" }, -- open buffer in new tab
            jump_close = { "o" }, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = { "zM", "zm" }, -- close all folds
            open_folds = { "zR", "zr" }, -- open all folds
            toggle_fold = { "zA", "za" }, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j", -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = true, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions", "lsp_references" }, -- for the given modes, automatically jump if there is only a single result
        use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
        signs = {
            error = " ",
            warning = " ",
            hint = " ",
            information = " ",
            other = "﫠",
        },
    })

    local keys = require("user.keymaps")

    keys.map("n", "<leader>wd", function()
        trouble.toggle("workspace_diagnostics")
    end, { desc = "Workspace Diagnostics (Trouble)" })

    keys.map("n", "<leader>dd", function()
        trouble.toggle("document_diagnostics")
    end, { desc = "Document Diagnostics (Trouble)" })

    keys.map("n", "<leader>ll", function()
        trouble.toggle("loclist")
    end, { desc = "Loclist (Trouble)" })

    keys.map("n", "<leader>qf", function()
        trouble.toggle("quickfix")
    end, { desc = "Quickfix (Trouble)" })

    keys.map("n", "<leader>tl", function()
        trouble.toggle("telescope")
    end, { desc = "Telescope Results (Trouble)" })
end
