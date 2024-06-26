return {
    "mrjones2014/smart-splits.nvim",
    enabled = false,
    build = "./kitty/install-kittens.bash",
    -- event = "WinResized",
    config = function()
        require("smart-splits").setup({})
    end,
    keys = {
        { "<C-k>", [[<CMD>lua require("smart-splits").move_cursor_up()<CR>]], desc = "Move cursor up" },
        { "<C-j>", [[<CMD>lua require("smart-splits").move_cursor_down()<CR>]], desc = "Move cursor down" },
        { "<C-h>", [[<CMD>lua require("smart-splits").move_cursor_left()<CR>]], desc = "Move cursor left" },
        { "<C-l>", [[<CMD>lua require("smart-splits").move_cursor_right()<CR>]], desc = "Move cursor right" },
        { "<C-S-k>", [[<CMD>lua require("smart-splits").resize_up(5)<CR>]], desc = "Resize window up" },
        { "<C-S-j>", [[<CMD>lua require("smart-splits").resize_down(5)<CR>]], desc = "Resize window down" },
        { "<C-S-h>", [[<CMD>lua require("smart-splits").resize_left(5)<CR>]], desc = "Resize window left" },
        { "<C-S-l>", [[<CMD>lua require("smart-splits").resize_right(5)<CR>]], desc = "Resize window right" },
    },
}
