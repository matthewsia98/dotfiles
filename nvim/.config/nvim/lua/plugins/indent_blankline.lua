return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
        local indent_blankline = require("indent_blankline")

        indent_blankline.setup({
            show_first_indent_level = false,
            char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
                "IndentBlanklineIndent3",
                "IndentBlanklineIndent4",
                "IndentBlanklineIndent5",
                "IndentBlanklineIndent6",
            },
        })

        -- Needed if loading on VeryLazy event
        indent_blankline.refresh()
    end,
}
