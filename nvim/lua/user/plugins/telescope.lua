local telescope = require('telescope')
local actions = require('telescope.actions')
-- local trouble_telescope = require('trouble.providers.telescope')

telescope.setup {
    defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                width = 0.99,
                preview_width = 0.5,
                preview_cutoff = 0,
                prompt_position = 'top',
            },
        },
        mappings = {
            i = {
                ['<C-h>'] = 'which_key',
                ['<C-t>'] = function(prompt_bufnr)
                    actions.send_to_loclist(prompt_bufnr)
                    vim.cmd [[Trouble loclist]]
                end,
            },
            n = {
                ['<C-t>'] = function(prompt_bufnr)
                    actions.send_to_loclist(prompt_bufnr)
                    vim.cmd [[Trouble loclist]]
                end,
                ['q'] = 'close',
            }
        }
    },
    pickers = {
        find_files = {
            layout_config = {
                preview_width = 0.7,
            },
        },
        find_buffers = {
            layout_config = {
                preview_width = 0.7,
            },
        },
        live_grep = {
            layout_config = {
                preview_width = 0.7,
            },
        },
        git_commits = {
            layout_config = {
                preview_width = 0.5,
            },
        },
        current_buffer_fuzzy_find = {
            layout_config = {
                preview_width = 0.4,
            }
        },
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown {
                -- even more opts
            }
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        }
    }
}
-- telescope.load_extension('ui-select')
-- telescope.load_extension('fzf')

map('n', '<leader>f/', '<cmd>Telescope find_files<CR>')
map('n', '<leader>ff', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>fg', '<cmd>Telescope git_commits<CR>')
map('n', '<leader>fa', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>fo', '<cmd>Telescope vim_options<CR>')
