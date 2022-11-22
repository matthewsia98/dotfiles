local installed, indent_blankline = pcall(require, "indent_blankline")

if installed then
    indent_blankline.setup({
        enabled = true,
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = true,
        show_trailing_blankline_indent = false,
        char = "▎",
        context_char = "▍",
        space_char_blankline = " ",
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
    })
end
