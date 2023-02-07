return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        width = 0.99,
                        height = 0.99,
                        preview_width = 0.5,
                        preview_cutoff = 0,
                        prompt_position = "top",
                    },
                },
                mappings = {
                    i = {
                        ["<C-q>"] = false,
                    },
                    n = {
                        ["<C-c>"] = actions.close,
                        ["<C-q>"] = false,
                    },
                },
            },
            extensions = {
                fzf = {},
            },
        })

        telescope.load_extension("fzf")
    end,
    keys = {
        { "<leader>fh", "<CMD>Telescope help_tags<CR>", desc = "Help Tags" },
        { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find Files" },
        { "<leader>fc", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Current Buffer Fuzzy Find" },
    },
}
