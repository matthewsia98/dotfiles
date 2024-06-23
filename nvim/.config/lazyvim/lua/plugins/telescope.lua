return {
    "nvim-telescope/telescope.nvim",
    opts = {
        defaults = {
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    width = 0.95,
                    height = 0.95,
                    preview_width = 0.5,
                    -- When columns are less than this value, the preview will be disabled
                    preview_cutoff = 1,
                },
            },
            mappings = {
                i = {
                    ["<C-h>"] = function()
                        local action_state = require("telescope.actions.state")
                        local line = action_state.get_current_line()
                        LazyVim.pick(
                            "find_files",
                            { hidden = true, default_text = line, prompt_title = "Find Files (Hidden)" }
                        )()
                    end,
                    ["<C-i>"] = function()
                        local action_state = require("telescope.actions.state")
                        local line = action_state.get_current_line()
                        LazyVim.pick(
                            "find_files",
                            { no_ignore = true, default_text = line, prompt_title = "Find Files (No ignore)" }
                        )()
                    end,
                },
            },
        },
    },
    keys = {
        { "<leader>fh", "<CMD>Telescope help_tags<CR>", desc = "Find Help" },
        { "<leader>fs", "<CMD>Telescope lsp_workspace_symbols<CR>", desc = "Find LSP Symbols" },
    },
}
