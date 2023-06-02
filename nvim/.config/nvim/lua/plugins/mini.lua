return {
    {
        "echasnovski/mini.comment",
        enabled = false,
        config = function()
            require("mini.comment").setup({})
        end,
        keys = {
            { "gc", mode = { "n", "v" }, desc = "Toggle Comment" },
        },
    },
    {
        "echasnovski/mini.cursorword",
        event = "VeryLazy",
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
            { "ys", desc = "Add surround" },
            { "ds", desc = "Delete surround" },
            { "cs", desc = "Change surround" },
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
