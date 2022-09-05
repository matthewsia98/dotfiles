local nvim_surround = require('nvim-surround')

nvim_surround.setup()

vim.cmd [[highlight default link NvimSurroundHighlight Visual]]

-- Line Text Objects
map({'o', 'x'}, 'il', ':<C-u>normal! ^v$<CR>')
map({'o', 'x'}, 'al', ':<C-u>normal! 0v$<CR>')
