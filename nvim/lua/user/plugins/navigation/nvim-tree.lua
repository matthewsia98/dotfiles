local installed, nvim_tree = pcall(require, 'nvim-tree')
local keys = require('user.keymaps')

if installed then
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
            dotfiles = false,
        },
    }

    keys.map('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>')
end
