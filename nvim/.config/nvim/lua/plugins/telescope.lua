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
        local trouble = require("trouble.providers.telescope")

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
                        ["<C-t>"] = trouble.open_with_trouble,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<C-c>"] = actions.close,
                        ["<C-t>"] = trouble.open_with_trouble,
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
        { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Find Buffers" },
        { "<leader>fc", "<CMD>Telescope commands<CR>", desc = "Commands" },
        { "<leader>fh", "<CMD>Telescope help_tags<CR>", desc = "Help Tags" },
        { "<leader>fo", "<CMD>Telescope vim_options<CR>", desc = "Options" },
        { "<leader>f/", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Current Buffer Fuzzy Find" },
        { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find Files" },
        { "<leader>.ff", "<CMD>Telescope find_files hidden=true<CR>", desc = "Find Files (Including hidden files)" },
        { "<leader>fl", "<CMD>Telescope live_grep_args<CR>", desc = "Live Grep" },
        {
            "<leader>.fl",
            function()
                require("telescope").extensions.live_grep_args.live_grep_args({
                    vimgrep_arguments = {
                        -- Defaults
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",

                        "--hidden",
                    },
                })
            end,
            desc = "Live Grep (--hidden)",
        },
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
            "<leader>fn",
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
