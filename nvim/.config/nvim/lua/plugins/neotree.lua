return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            enable_git_status = true,
            enable_diagnostics = true,
            filesystem = {
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
