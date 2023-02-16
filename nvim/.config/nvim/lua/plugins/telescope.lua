return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    cmd = "Telescope",
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                sorting_strategy = "ascending",
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
                        ["q"] = actions.close,
                        ["<C-c>"] = actions.close,
                        ["<C-q>"] = false,
                    },
                },
            },
            pickers = {
                live_grep = {
                    mappings = {
                        i = { ["<C-f>"] = actions.to_fuzzy_refine },
                    },
                },
            },
            extensions = {
                fzf = {},
                live_grep_args = {
                    mappings = {
                        i = { ["<C-f>"] = actions.to_fuzzy_refine },
                    },
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
    end,
    keys = {
        { "<leader>fh", "<CMD>Telescope help_tags<CR>", desc = "Help Tags" },
        { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find Files" },
        { "<leader>f.f", "<CMD>Telescope find_files hidden=true<CR>", desc = "Find Files (Including hidden files)" },
        { "<leader>f/", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Current Buffer Fuzzy Find" },
        { "<leader>fa", "<CMD>Telescope live_grep_args<CR>", desc = "Live Grep" },
        { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Find Buffers" },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").grep_string({
                    search = "",
                    only_sort_text = true,
                })
            end,
            desc = "Grep String",
        },
        {
            "<leader>fc",
            function()
                require("telescope.builtin").find_files({
                    prompt_title = "Neovim Config",
                    search_dirs = { vim.fn.stdpath("config") },
                })
            end,
            desc = "Find Files (Neovim Config)",
        },
    },
}
