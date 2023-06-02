return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    -- event = { "BufReadPost", "BufNewFile" },
    event = "VeryLazy",
    config = function()
        require("todo-comments").setup({
            signs = false,
            keywords = {
                REFERENCE = { icon = "", color = "hint" },
                DEBUG = { icon = "", color = "debug" },
                ERROR = { icon = "", color = "error" },
            },
            highlight = {
                comments_only = false,
                multiline = false,
            },
            colors = {
                debug = { "Normal" },
            },
        })
    end,
    keys = {
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            desc = "Next todo comment",
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            desc = "Previous todo comment",
        },
    },
}
