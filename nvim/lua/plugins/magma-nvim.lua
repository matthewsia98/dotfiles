vim.g.magma_automatically_open_output = true
vim.g.magma_image_provider = 'ueberzug'
vim.g.magma_cell_highlight_group = 'PmenuSel'

map('n', '<Leader>mi', '<cmd>MagmaInit<CR>')
map('n', '<Leader>mr', '<cmd>MagmaEvaluateLine<CR>')
map('x', '<Leader>mr', ':<C-u>MagmaEvaluateVisual<CR>')
map('n', '<Leader>mrr', '<cmd>MagmaReevaluateCell<CR>')
map('n', '<Leader>mo', '<cmd>MagmaShowOutput<CR>')
map('n', '<Leader>moo', '<cmd>MagmaEnterOutput<CR>')
map('n', '<Leader>mc', '<cmd>MagmaInterrupt<CR>')
map('n', '<Leader>mrs', '<cmd>MagmaRestart<CR>')
map('n', '<Leader>mrst', '<cmd>MagmaRestart!<CR>')
map('n', '<Leader>md', '<cmd>MagmaDelete<CR>')
map('n', '<Leader>mq', '<cmd>MagmaDeinit<CR>')
