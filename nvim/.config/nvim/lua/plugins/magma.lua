return {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    enabled = false,
    config = function()
        vim.g.magma_image_provider = "kitty"
        vim.g.magma_automatically_open_output = true
        vim.g.magma_wrap_output = true
        vim.g.magma_output_window_borders = true
        vim.g.magma_cell_highlight_group = "CursorLine"
    end,
    keys = {
        { "<LocalLeader>r", "<CMD>MagmaEvaluateOperator<CR>", desc = "" },
        { "<LocalLeader>rr", "<CMD>MagmaEvaluateLine<CR>", desc = "" },
        { "<LocalLeader>r", "<CMD><C-u>MagmaEvaluateVisual<CR>", desc = "" },
        { "<LocalLeader>rc", "<CMD>MagmaReevaluateCell<CR>", desc = "" },
        { "<LocalLeader>rd", "<CMD>MagmaDelete<CR>", desc = "" },
        { "<LocalLeader>ro", "<CMD>MagmaShowOutput<CR>", desc = "" },
    },
}
