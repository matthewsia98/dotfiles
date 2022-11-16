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
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<C-t>"] = function(prompt_bufnr)
                        actions.send_to_loclist(prompt_bufnr)
                        vim.cmd([[Trouble loclist]])
                    end,
                },
                n = {
                    ["<C-t>"] = function(prompt_bufnr)
                        actions.send_to_loclist(prompt_bufnr)
                        vim.cmd([[Trouble loclist]])
                    end,
                    ["q"] = "close",
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
    keys.map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
    keys.map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>")
    keys.map("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
    keys.map("n", "<leader>fg", "<cmd>Telescope git_commits<CR>")
    keys.map("n", "<leader>fa", "<cmd>Telescope live_grep<CR>")
    keys.map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
    keys.map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
    keys.map("n", "<leader>fo", "<cmd>Telescope vim_options<CR>")
end
