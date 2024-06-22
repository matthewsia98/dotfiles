return {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
        local find_files_no_ignore = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
        end
        local find_files_with_hidden = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            LazyVim.pick("find_files", { hidden = true, default_text = line })()
        end
        opts.defaults.mappings = vim.tbl_deep_extend("force", opts.defaults.mappings, {
            i = {
                ["<C-h>"] = find_files_with_hidden,
                ["<C-i>"] = find_files_no_ignore,
            },
        })
    end,
    keys = {
        { "<leader>fh", "<CMD>Telescope help_tags<CR>", desc = "Find Help" },
    },
}
