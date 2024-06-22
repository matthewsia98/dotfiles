return {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    opts = {
        keymaps = {
            ["q"] = "actions.close",
            ["<C-h>"] = "actions.toggle_hidden",
            [".."] = "actions.parent",
        },
    },
}
