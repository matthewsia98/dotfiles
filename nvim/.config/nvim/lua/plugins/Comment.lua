return {
    "numToStr/Comment.nvim",
    enabled = true,
    config = function()
        require("Comment").setup({})
    end,
    keys = {
        { "gc", mode = { "n", "v" }, desc = "Toggle Comment" },
        { "gb", mode = { "n", "v" }, desc = "Toggle Comment (Blockwise)" },
    },
}
