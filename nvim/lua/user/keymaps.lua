local M = {}

local function map(mode, key, value, options)
    local default_options = { silent = true, noremap = true }
    if options ~= nil then
        options = vim.tbl_extend('keep', options, default_options)
    else
        options = default_options
    end
    vim.keymap.set(mode, key, value, options)
end
M.map = map

local function nvim_map(mode, key, value, options)
    local default_options = { silent = true, noremap = true }
    if options ~= nil then
        options = vim.tbl_extend('keep', options, default_options)
    else
        options = default_options
    end
    vim.api.nvim_set_keymap(mode, key, value, options)
end
M.nvim_map = nvim_map

local function unmap(mode, key, options)
    vim.keymap.del(mode, key, options)
end
M.unmap = unmap

-- Go to start and end of line
map('i', '<C-E>', '<Esc>A')
map('n', '<C-E>', 'A<Esc>')
map('i', '<C-A>', '<Esc>I')
map('n', '<C-A>', 'I<Esc>')

-- Insert blank lines
map('n', '<CR>', 'o<Esc>')
map('n', '<S-CR>', 'O<Esc>')

-- Move Lines
map('n', '<C-n>', '<cmd>move .+1<CR>')
map('n', '<C-p>', '<cmd>move .-2<CR>')

-- Windows
-- Close window
map('n', '<C-q>', '<C-w>c')
-- Move between windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
-- Window Resize
map('n', '<Right>', '<C-w>5>')
map('n', '<Left>', '<C-w>5<')
map('n', '<Up>', '<C-w>1+')
map('n', '<Down>', '<C-w>1-')

-- Folds
-- map('n', '<leader>fd', 'za')

-- Terminal Mode
map('t', '<C-q>', '<C-\\><C-n><C-w>c')
map('t', '<Esc>', '<C-\\><C-n>')

-- Toggle conceal
map('n', '<F12>',
    function()
        if vim.o.conceallevel == 2 then
            vim.o.conceallevel = 0
        else
            vim.o.conceallevel = 2
        end
    end
)

-- Line Text Objects
map({'o', 'x'}, 'il', ':<C-u>normal! ^v$<CR>', { desc = 'inner line' })
map({'o', 'x'}, 'al', ':<C-u>normal! 0v$<CR>', { desc = 'a line (with whitespace)' })

-- Colemak
-- map('i', 'e', 'f')
-- map('i', 'r', 'p')
-- map('i', 't', 'b')
-- map('i', 'y', 'j')
-- map('i', 'u', 'l')
-- map('i', 'i', 'u')
-- map('i', 'o', 'y')
-- map('i', 'p', ';')
-- map('i', 's', 'r')
-- map('i', 'd', 's')
-- map('i', 'f', 't')
-- map('i', 'h', 'm')
-- map('i', 'j', 'n')
-- map('i', 'k', 'e')
-- map('i', 'l', 'i')
-- map('i', ';', 'o')
-- map('i', 'z', 'x')
-- map('i', 'x', 'c')
-- map('i', 'c', 'd')
-- map('i', 'b', 'z')
-- map('i', 'n', 'k')
-- map('i', 'm', 'h')

return M
