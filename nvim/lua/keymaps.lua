-- Go to start and end of line
map('i', '<C-E>', '<Esc>A')
map('n', '<C-E>', 'A<Esc>')
map('i', '<C-A>', '<Esc>I')
map('n', '<C-A>', 'I<Esc>')

-- Insert blank lines
map('n', '<CR>', 'o<Esc>')
map('n', '<S-CR>', 'O<Esc>')

-- Move Lines
-- map('n', '<C-n>', '<cmd>move .+1<CR>')
-- map('n', '<C-p>', '<cmd>move .-2<CR>')

-- Window Splits
vim.cmd [[highlight WinSeparator guibg=NONE guifg=#B7BDF8]]
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

-- Reload Config
map('n', '<F4>', '<cmd>source %<CR>')

-- Terminal Mode
map('t', '<C-q>', '<C-\\><C-n><C-w>c')
map('t', '<Esc>', '<C-\\><C-n>')
map('t', '<C-h>', '<C-\\><C-n><C-w>h')
map('t', '<C-j>', '<C-\\><C-n><C-w>j')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')
map('t', '<C-l>', '<C-\\><C-n><C-w>l')

map('n', '<F12>',
    function()
        if vim.o.conceallevel == 2 then
            vim.o.conceallevel = 0
        else
            vim.o.conceallevel = 2
        end
    end
)

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
