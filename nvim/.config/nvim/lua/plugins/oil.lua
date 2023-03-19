return {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
        require("oil").setup({
            use_default_keymaps = false,
            keymaps = {
                ["H"] = "actions.toggle_hidden",
                ["q"] = "actions.close",
                ["<C-c>"] = "actions.close",
                ["<CR>"] = "actions.select",
                ["g?"] = "actions.show_help",
            },
            view_options = {
                show_hidden = false,
            },
            float = {
                win_options = {
                    winblend = 8,
                },
            },
        })
    end,
    keys = {
        { "<leader>o", "<CMD>Oil --float<CR>", desc = "Open oil float" },
    },
}
