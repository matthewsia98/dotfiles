return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        if vim.fn.argc() == 1 then
            ---@diagnostic disable-next-line: param-type-mismatch
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("neo-tree")
            end
        end
    end,
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            enable_git_status = true,
            enable_diagnostics = true,
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
                hijack_netrw_behaviour = "open_current",
                filtered_items = {
                    visible = true, -- grey out dotfiles
                    hide_dotfiles = false,
                },
            },
            window = {
                width = 40,
                mappings = {
                    ["<space>"] = false,
                },
            },
        })
    end,
    keys = {
        { "<leader>nt", "<CMD>Neotree toggle<CR>", desc = "Toggle File Explorer" },
    },
}
