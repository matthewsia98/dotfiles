return {
    "lukas-reineke/headlines.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown", "norg" },
    config = function()
        require("headlines").setup({})
    end,
}
