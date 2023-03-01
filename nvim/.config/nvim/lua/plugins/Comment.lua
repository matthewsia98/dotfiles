return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({})
    end,
    keys = {
        { "gc", mode = { "n", "v" }, desc = "Toggle Comment" },
        { "gb", mode = { "n", "v" }, desc = "Toggle Comment (Blockwise)" },
    },
}
