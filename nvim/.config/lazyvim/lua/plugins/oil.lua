return {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    init = function()
        if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            require("oil")
        end
    end,
    opts = {
        keymaps = {
            ["q"] = "actions.close",
            ["<C-h>"] = "actions.toggle_hidden",
            [".."] = "actions.parent",
        },
    },
    keys = {
        { "<leader>o", "<CMD>Oil<CR>", desc = "Open Oil" },
    },
}
