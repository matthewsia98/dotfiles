return {
    "folke/zen-mode.nvim",
    enabled = false,
    cmd = "ZenMode",
    config = function()
        require("zen-mode").setup({
            window = {
                width = 1,
                height = 1,
            },
        })
    end,
}
