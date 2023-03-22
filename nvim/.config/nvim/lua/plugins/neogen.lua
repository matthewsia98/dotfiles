return {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Neogen",
    config = function()
        require("neogen").setup({
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "numpydoc",
                    },
                },
            },
        })
    end,
}
