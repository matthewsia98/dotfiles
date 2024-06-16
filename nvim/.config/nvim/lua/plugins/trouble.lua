return {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
        require("trouble").setup({
            auto_open = false,
            auto_preview = true,
            auto_jump = { "loclist", "quickfix", "lsp_definitions", "lsp_references", "lsp_type_definitions" },
            padding = false,
            use_diagnostic_signs = true,
            action_keys = {
                jump = { "<CR>" },
                jump_close = { "o" },
            },
        })
    end,
    keys = {
        -- { "<leader>wd", "<CMD>Trouble workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
        { "<leader>dd", "<CMD>Trouble diagnostics toggle focus=true<CR>", desc = "Document Diagnostics" },
    },
}
