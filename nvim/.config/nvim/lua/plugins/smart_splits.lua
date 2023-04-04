return {
    "mrjones2014/smart-splits.nvim",
    build = "./install-kitty.sh",
    event = "WinResized",
    config = function()
        require("smart-splits").setup({})
    end,
    keys = {
        { "<C-k>", [[<CMD>lua require("smart-splits").move_cursor_up()<CR>]], desc = "Move cursor up" },
        { "<C-j>", [[<CMD>lua require("smart-splits").move_cursor_down()<CR>]], desc = "Move cursor down" },
        { "<C-h>", [[<CMD>lua require("smart-splits").move_cursor_left()<CR>]], desc = "Move cursor left" },
        { "<C-l>", [[<CMD>lua require("smart-splits").move_cursor_right()<CR>]], desc = "Move cursor right" },
        { "<C-up>", [[<CMD>lua require("smart-splits").resize_up()<CR>]], desc = "Resize window up" },
        { "<C-down>", [[<CMD>lua require("smart-splits").resize_down()<CR>]], desc = "Resize window down" },
        { "<C-left>", [[<CMD>lua require("smart-splits").resize_left()<CR>]], desc = "Resize window left" },
        { "<C-right>", [[<CMD>lua require("smart-splits").resize_right()<CR>]], desc = "Resize window right" },
    },
}
