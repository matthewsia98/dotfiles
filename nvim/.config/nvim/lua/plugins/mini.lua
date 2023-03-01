return {
    {
        "echasnovski/mini.cursorword",
        event = "CursorMoved",
        config = function()
            require("mini.cursorword").setup({})
        end,
    },
    {
        "echasnovski/mini.surround",
        enabled = false,
        config = function()
            require("mini.surround").setup({
                mappings = {
                    add = "ys",
                    delete = "ds",
                    replace = "cs",
                },
            })
        end,
        keys = {
            { "ys", desc = "" },
            { "ds", desc = "" },
            { "cs", desc = "" },
        },
    },
}
