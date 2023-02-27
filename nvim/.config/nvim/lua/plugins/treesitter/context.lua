require("treesitter-context").setup({
    enable = true,
    patterns = {
        lua = {
            "table_constructor",
        },
        python = {
            "call",
        },
    },
})
