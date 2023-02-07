return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
	config = function(_, opts)
		require("indent_blankline").setup({
            char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
                "IndentBlanklineIndent3",
                "IndentBlanklineIndent4",
                "IndentBlanklineIndent5",
                "IndentBlanklineIndent6",
            },
        })
	end,
}
