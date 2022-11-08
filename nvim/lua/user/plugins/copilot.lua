local keys = require('user.keymaps')

-- Next and Prev mappings in ~/.config/nvim/lua/user/plugins/lsp/luasnip.lua
-- vim.cmd [[ imap <silent><script><expr> <C-Space> copilot#Accept() ]]
keys.map('i', '<C-Space>', 'copilot#Accept()', { expr = true })
keys.map('i', '<C-c>', 'copilot#Dismiss()', { expr = true })
vim.g.copilot_no_tab_map = true
