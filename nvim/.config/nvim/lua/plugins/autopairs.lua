return {
    "windwp/nvim-autopairs",
    enabled = true,
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({})
    end,
}
