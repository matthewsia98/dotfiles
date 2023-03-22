return {
    "stevearc/oil.nvim",
    cmd = "Oil",
    init = function()
        if vim.fn.argc() == 0 then
            vim.schedule(function()
                require("oil").open()
            end)
        end

        if vim.fn.argc() == 1 then
            ---@diagnostic disable-next-line: param-type-mismatch
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("oil")
            end
        end
    end,
    config = function()
        require("oil").setup({
            use_default_keymaps = false,
            keymaps = {
                ["<C-h>"] = "actions.toggle_hidden",
                ["q"] = "actions.close",
                ["<C-c>"] = "actions.close",
                ["<CR>"] = "actions.select",
                ["g?"] = "actions.show_help",
                ["<C-r>"] = "actions.refresh",
                [".."] = "actions.parent",
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
        { "<leader>o", "<CMD>Oil<CR>", desc = "Open oil float" },
    },
}
