local keys = require('user.keymaps')

keys.map('i', '<M-[>', '<Plug>(copilot-previous)')
keys.map('i', '<M-]>', '<Plug>(copilot-next)')
keys.map('i', '<M-Space>', '<Plug>(copilot-dismiss)')
