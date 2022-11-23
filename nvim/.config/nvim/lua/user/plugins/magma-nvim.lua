local keys = require("user.keymaps")

vim.g.magma_automatically_open_output = true
vim.g.magma_image_provider = "ueberzug"
vim.g.magma_cell_highlight_group = "PmenuSel"

keys.map("n", "<Leader>mi", "<cmd>MagmaInit<CR>")
keys.map("n", "<Leader>mr", "<cmd>MagmaEvaluateLine<CR>")
keys.map("x", "<Leader>mr", ":<C-u>MagmaEvaluateVisual<CR>")
keys.map("n", "<Leader>mrr", "<cmd>MagmaReevaluateCell<CR>")
keys.map("n", "<Leader>mo", "<cmd>MagmaShowOutput<CR>")
keys.map("n", "<Leader>moo", "<cmd>MagmaEnterOutput<CR>")
keys.map("n", "<Leader>mc", "<cmd>MagmaInterrupt<CR>")
keys.map("n", "<Leader>mrs", "<cmd>MagmaRestart<CR>")
keys.map("n", "<Leader>mrst", "<cmd>MagmaRestart!<CR>")
keys.map("n", "<Leader>md", "<cmd>MagmaDelete<CR>")
keys.map("n", "<Leader>mq", "<cmd>MagmaDeinit<CR>")
