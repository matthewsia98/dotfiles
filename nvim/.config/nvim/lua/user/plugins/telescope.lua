local installed, telescope = pcall(require, "telescope")

if installed then
    local actions = require("telescope.actions")

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
            },
            default_mappings = {
                i = {
                    ["<C-q>"] = actions.close,
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,
                    ["<CR>"] = actions.select_default,
                },
                n = {
                    ["<C-q>"] = actions.close,
                    ["gg"] = actions.move_to_top,
                    ["G"] = actions.move_to_bottom,
                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,
                    ["<CR>"] = actions.select_default,
                    ["?"] = actions.which_key,
                },
            },
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<C-l>"] = function(prompt_bufnr)
                        actions.send_to_loclist(prompt_bufnr)
                        vim.cmd([[Trouble loclist]])
                    end,
                    ["<C-q>"] = function(prompt_bufnr)
                        actions.send_to_qflist(prompt_bufnr)
                        vim.cmd([[Trouble quickfix]])
                    end,
                },
                n = {
                    ["<C-l>"] = function(prompt_bufnr)
                        actions.send_to_loclist(prompt_bufnr)
                        vim.cmd([[Trouble loclist]])
                    end,
                    ["<C-q>"] = function(prompt_bufnr)
                        actions.send_to_qflist(prompt_bufnr)
                        vim.cmd([[Trouble quickfix]])
                    end,
                    ["q"] = actions.close,
                },
            },
        },
        pickers = {},
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
        },
    })

    local keys = require("user.keymaps")
    keys.map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>")
    keys.map("n", "<leader>fwd", "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.getcwd() })<CR>")
    keys.map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').oldfiles()<CR>")
    keys.map("n", "<leader>fc", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
    keys.map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').git_commits()<CR>")
    -- keys.map("n", "<leader>fa", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
    keys.map("n", "<leader>fa", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    keys.map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
    keys.map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
    keys.map("n", "<leader>fo", "<cmd>lua require('telescope.builtin').vim_options()<CR>")
end
