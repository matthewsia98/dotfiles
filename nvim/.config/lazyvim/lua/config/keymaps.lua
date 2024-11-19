local map = vim.keymap.set

-- Resize window
map("n", "<C-S-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-S-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("i", "<C-a>", "<C-o><S-i>", { desc = "Go to start of line" })
map("i", "<C-e>", "<C-o><S-a>", { desc = "Go to end of line" })
