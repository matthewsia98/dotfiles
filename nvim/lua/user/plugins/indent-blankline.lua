local installed, indent_blankline = pcall(require, 'indent_blankline')

if installed then
    indent_blankline.setup {
        enabled = true,
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = true,
        show_trailing_blankline_indent = false,
        space_char_blankline = ' ',
        char_highlight_list = {
            'IndentBlanklineIndent1',
            'IndentBlanklineIndent2',
            'IndentBlanklineIndent3',
            'IndentBlanklineIndent4',
            'IndentBlanklineIndent5',
            'IndentBlanklineIndent6',
        },
    }

    -- vim.cmd [[highlight IndentBlanklineChar guifg=#B7BDF8 gui=nocombine]] -- color of indent lines
    -- vim.cmd [[highlight IndentBlanklineContextChar guifg=#FF00FF gui=nocombine]] -- color of current context indent line (vertical line)
    -- vim.cmd [[highlight IndentBlanklineContextStart guisp=#FF00FF gui=underline]] -- color of current context start (underline)
end
