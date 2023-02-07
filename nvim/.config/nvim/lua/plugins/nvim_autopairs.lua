return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function(_, opts)
        require("nvim-autopairs").setup({

        })
    end,
}
