local keys = require("user.keymaps")

vim.g.git_messenger_no_default_mappings = true
vim.g.git_messenger_always_into_popup = false

keys.map("n", "<leader>gm", "<cmd>GitMessenger<CR>")
