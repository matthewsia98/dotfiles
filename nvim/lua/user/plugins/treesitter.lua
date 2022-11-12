local installed, treesitter = pcall(require, 'nvim-treesitter.configs')

if installed then
    treesitter.setup {
        auto_install = true,
        ensure_installed = {
            'vim',
            'help',
            'lua',
            'python',
            'comment',
            'bash',
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = false,
            disable = { 'python' },
        },
        incremental_selection = {
            enable = false,
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                    -- ['eh'] = '@assignment.left',
                    -- ['el'] = '@assignment.right',
                    -- ['aa'] = '@parameter.outer',
                    -- ['ia'] = '@parameter.inner',
                    -- ['ap'] = '@print.outer',
                    -- ['ip'] = '@print.inner',
                },
                -- selection_modes = {
                    ['@parameter.outer'] = 'v',
                    ['@function.outer'] = 'V',
                    ['@class.outer'] = '<C-v>',
                -- },
                include_surrounding_whitespace = false,
            },
            swap = {
                enable = true,
                swap_next = {
                    -- ['<C-p>l'] = '@parameter.inner',
                    -- ['snf'] = '@function.outer',
                },
                swap_previous = {
                    -- ['<C-p>h'] = '@parameter.inner',
                    -- ['spf'] = '@function.outer',
                },
            },
            move = {
                enable = true,
                set_jumps = false,
                goto_next_start = {
                    [']f'] = '@function.outer',
                    [']c'] = '@class.outer',
                    [']P'] = '@print.outer',
                },
                goto_next_end = {
                    [']F'] = '@function.outer',
                    [']C'] = '@class.outer',
                    [']p'] = '@print.outer',
                },
                goto_previous_start = {
                    ['[f'] = '@function.outer',
                    ['[c'] = '@class.outer',
                    ['[P'] = '@print.outer',
                },
                goto_previous_end = {
                    ['[F'] = '@function.outer',
                    ['[C'] = '@class.outer',
                    ['[p'] = '@print.outer',
                },
            }
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
                toggle_query_editor = 'o',
                toggle_hl_groups = 'i',
                toggle_injected_languages = 't',
                toggle_anonymous_nodes = 'a',
                toggle_language_display = 'I',
                focus_language = 'f',
                unfocus_language = 'F',
                update = 'R',
                goto_node = '<cr>',
                show_help = '?',
            },
        }
    }
end
