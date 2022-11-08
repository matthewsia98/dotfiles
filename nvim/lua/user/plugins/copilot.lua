local keys = require('user.keymaps')

-- Next and Prev mappings in ~/.config/nvim/lua/user/plugins/lsp/luasnip.lua
vim.cmd [[ imap <silent><script><expr> <C-Space> copilot#Accept("\<CR>") ]]
keys.map('i', '<C-c>', function()
    vim.cmd [[ call copilot#Dismiss() ]]
end)
vim.g.copilot_no_tab_map = true
