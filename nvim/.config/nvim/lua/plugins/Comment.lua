return {
    "numToStr/Comment.nvim",
    enabled = false,
    config = function()
        require("Comment").setup({})
    end,
    keys = {
        { "gc", mode = { "n", "v" }, desc = "Toggle Comment" },
        { "gb", mode = { "n", "v" }, desc = "Toggle Comment (Blockwise)" },
    },
}
