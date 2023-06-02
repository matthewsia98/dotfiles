return {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
        require("colorizer").setup({
            user_default_options = {
                names = false,
            },
        })

        vim.defer_fn(function()
            require("colorizer").attach_to_buffer(0)
        end, 0)
    end,
}
