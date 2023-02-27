return {
    "numToStr/Navigator.nvim",
    config = function()
        require("Navigator").setup({})
    end,
    keys = {
        { "<C-h>", "<CMD>NavigatorLeft<CR>", desc = "" },
        { "<C-l>", "<CMD>NavigatorRight<CR>", desc = "" },
        { "<C-k>", "<CMD>NavigatorUp<CR>", desc = "" },
        { "<C-j>", "<CMD>NavigatorDown<CR>", desc = "" },
        -- { "<C-p>", "<CMD>NavigatorPrevious<CR>", desc = "" },
    },
}
