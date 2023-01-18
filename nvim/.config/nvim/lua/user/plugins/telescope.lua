local installed, telescope = pcall(require, "telescope")

if installed then
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
        defaults = {
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    width = 0.99,
                    preview_width = 0.5,
                    preview_cutoff = 0,
                    prompt_position = "top",
                },
                vertical = {
                    width = 0.99,
                    height = 0.99,
                    preview_height = 0.5,
                    preview_cutoff = 0,
                    prompt_position = "bottom",
                },
            },
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<C-t>"] = function(prompt_bufnr)
                        require("trouble.providers.telescope").open_with_trouble(prompt_bufnr, "loclist")
                    end,
                },
                n = {
                    ["<C-t>"] = function(prompt_bufnr)
                        require("trouble.providers.telescope").open_with_trouble(prompt_bufnr, "loclist")
                    end,
                    ["q"] = actions.close,
                },
            },
        },
        pickers = {
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
            live_grep = {
                mappings = {
                    i = {
                        ["<C-f>"] = actions.to_fuzzy_refine,
                    },
                },
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({
                    -- even more opts
                }),
            },
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
            live_grep_args = {
                auto_quoting = true,
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
                mappings = {
                    -- i = {
                    --     ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                    --     ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob" }),
                    -- }
                },
            },
            undo = {
                use_delta = true, -- use git-delta
                side_by_side = true,
                layout_strategy = "vertical",
                layout_config = {
                    preview_height = 0.8,
                },
                mappings = {
                    i = {
                        ["<CR>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-CR>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-CR>"] = require("telescope-undo.actions").restore,
                    },
                },
            },
        },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("undo")

    local keys = require("user.keymaps")

    local wk_installed, wk = pcall(require, "which-key")
    if wk_installed then
        wk.register({
            ["<leader>"] = {
                f = {
                    name = "Telescope",
                },
            },
        })
    end

    keys.map("n", "<leader>ff", function()
        builtin.find_files()
    end, { desc = "Find Files" })

    keys.map("n", "<leader>fr", function()
        builtin.oldfiles()
    end, { desc = "Find Recent Files" })

    keys.map("n", "<leader>fc", function()
        builtin.current_buffer_fuzzy_find()
    end, { desc = "Fuzzy Find" })

    keys.map("n", "<leader>fg", function()
        builtin.git_commits()
    end, { desc = "Find Git Commits" })

    keys.map("n", "<leader>fb", function()
        builtin.buffers()
    end, { desc = "Find Buffers" })

    keys.map("n", "<leader>fh", function()
        builtin.help_tags()
    end, { desc = "Find Vim Help" })

    keys.map("n", "<leader>fo", function()
        builtin.vim_options()
    end, { desc = "Find Vim Options" })

    keys.map("n", "<leader>fa", function()
        builtin.grep_string({ only_sort_text = true, search = "" })
    end, { desc = "" })

    keys.map("n", "<leader>fl", function()
        builtin.live_grep()
    end, { desc = "Live Grep" })
    -- keys.map("n", "<leader>fa", function()
    --     telescope.extensions.live_grep_args.live_grep_args()
    -- end, { desc = "Live Grep" })

    keys.map("n", "<leader>fu", function()
        telescope.extensions.undo.undo()
    end, { desc = "Find Undo Tree" })
end
