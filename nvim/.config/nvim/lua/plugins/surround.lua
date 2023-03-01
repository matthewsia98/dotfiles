return {
    "kylechui/nvim-surround",
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
    keys = {
        { "ys", desc = "" },
        { "ds", desc = "" },
        { "cs", desc = "" },
    },
}
