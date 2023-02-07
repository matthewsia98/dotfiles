return {
    "kevinhwang91/nvim-hlslens",
    event = "CmdlineEnter",
    config = function()
        require("hlslens").setup({})
    end,
}
