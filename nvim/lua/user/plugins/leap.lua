local installed, leap = pcall(require, 'leap')

if installed then
    local keys = require('user.keymaps')
    keys.map({ 'n', 'x', 'o', }, '-', '<Plug>(leap-forward-to)')
    keys.map({ 'n', 'x', 'o' }, '_', '<Plug>(leap-backward-to)')
    keys.map('n', 'g-', '<Plug>(leap-cross-window)')
    -- leap.add_default_mappings()
end
