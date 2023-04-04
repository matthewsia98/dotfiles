return {
    "mrjones2014/smart-splits.nvim",
    event = "WinResized",
    config = function()
        require("smart-splits").setup({})
    end,
    keys = {
        { "<C-S-k>", [[<CMD>lua require("smart-splits").resize_up()<CR>]], desc = "Resize window up" },
        { "<C-S-j>", [[<CMD>lua require("smart-splits").resize_down()<CR>]], desc = "Resize window down" },
        { "<C-S-h>", [[<CMD>lua require("smart-splits").resize_left()<CR>]], desc = "Resize window left" },
        { "<C-S-l>", [[<CMD>lua require("smart-splits").resize_right()<CR>]], desc = "Resize window right" },
    },
}
