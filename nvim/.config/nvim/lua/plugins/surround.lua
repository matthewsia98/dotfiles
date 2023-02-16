return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            keymaps = {
                normal = "ys",
                delete = "ds",
                change = "cs",
            },
            aliases = {
                b = { ")", "}", "]" },
            },
        })
    end,
}
