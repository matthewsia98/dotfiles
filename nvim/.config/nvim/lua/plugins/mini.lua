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
    {
        "echasnovski/mini.align",
        config = function()
            require("mini.align").setup({
                mappings = {
                    start = "ga",
                    start_with_preview = "gA",
                },
            })
        end,
        keys = {
            { "ga", mode = { "n", "v" } },
            { "gA", mode = { "n", "v" } },
        },
    },
    {
        "echasnovski/mini.animate",
        enabled = false,
        event = "VeryLazy",
        config = function()
            require("mini.animate").setup({})
        end,
    },
}
