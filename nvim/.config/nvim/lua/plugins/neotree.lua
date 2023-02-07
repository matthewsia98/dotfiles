return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    config = function()
        require("neo-tree").setup({
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
            event_handlers = {
                {
                    event = "neo_tree_window_after_open",
                    handler = function(args)
                        vim.api.nvim_win_set_option(args.winid, "statuscolumn", "")
                    end,
                },
            },
        })
    end,
    keys = {
        { "<leader>nt", "<CMD>Neotree toggle<CR>", desc = "Toggle File Explorer" },
    },
}
