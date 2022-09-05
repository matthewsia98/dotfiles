local nvim_tree = require('nvim-tree')

nvim_tree.setup {
    sort_by = 'case_sensitive',
    view = {
        adaptive_size = false,
        mappings = {
            list = {
                { key = 'u', action = 'dir_up' },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
}

map('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>')
