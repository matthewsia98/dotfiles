local installed, leap = pcall(require, 'leap')

if installed then
    local keys = require('user.keymaps')
    keys.map('n', '-', '<Plug>(leap-forward)')
    keys.map('n', '_', '<Plug>(leap-backward)')
    -- leap.add_default_mappings()
end
