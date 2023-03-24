return {
    "kevinhwang91/nvim-hlslens",
    enabled = false,
    config = function()
        require("hlslens").setup({
            calm_down = false,
        })
    end,
    keys = {
        { "/", desc = "" },
        { "<leader>sh", "<CMD>HlSearchLensToggle<CR>", desc = "Toggle search highlights" },
    },
}
