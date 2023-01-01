local M = {}

local function map(modes, key, value, options)
    local default_options = { silent = true, noremap = true }

    if options ~= nil then
        options = vim.tbl_extend("keep", options, default_options)
    else
        options = default_options
    end

    vim.keymap.set(modes, key, value, options)
end
M.map = map

local function nvim_map(mode, key, value, options)
    local default_options = { silent = true, noremap = true }

    if options ~= nil then
        options = vim.tbl_extend("keep", options, default_options)
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
map("i", "<C-a>", "<Esc>I")
map("i", "<C-e>", "<Esc>A")

-- Insert blank lines
map("n", "<CR>", "o<Esc>")
map("n", "<S-CR>", "O<Esc>")

-- Correct indentation when inserting on blank line
map("n", "i", function()
    local line = vim.fn.getline(".")
    if #line == 0 then
        return "cc"
    else
        return "i"
    end
end, { expr = true })

-- Windows
-- Close Window
map("n", "<C-q>", "<C-w>c")
-- Move between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
-- Resize Windows
map("n", "<Right>", "<C-w>5>")
map("n", "<Left>", "<C-w>5<")
map("n", "<Up>", "<C-w>1+")
map("n", "<Down>", "<C-w>1-")

-- Delete buffer
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Folds
-- map('n', '<leader>fd', 'za')

-- Terminal Mode
map("t", "<Esc>", "<C-\\><C-n>")
map("t", "<C-q>", "<C-\\><C-n><C-w>c")
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")

-- Toggle conceal
map("n", "<leader>cn", function()
    if vim.o.conceallevel == 2 then
        vim.o.conceallevel = 0
    else
        vim.o.conceallevel = 2
    end
end, { desc = "Toggle conceal" })

-- Reverse Selection
map("v", "<leader>rv", '<ESC><cmd>lua require("user.functions").reverse_lines()<CR>', { desc = "Reverse visual lines" })

-- Get Current FIle
map(
    "n",
    "<leader>/",
    '<cmd>lua require("user.functions").get_current_file("absolute")<CR>',
    { desc = "Get absolute path" }
)
map(
    "n",
    "<leader>.",
    '<cmd>lua require("user.functions").get_current_file("relative")<CR>',
    { desc = "Get relative path" }
)

-- Toggle Highlight Search
map("n", "<leader>sh", "<cmd>set hlsearch!<CR>", { desc = "Toggle highlight search" })

-- Line Text Objects
-- map({'o', 'x'}, 'il', ':<C-u>normal! ^v$<CR>', { desc = 'inner line' })
-- map({'o', 'x'}, 'al', ':<C-u>normal! 0v$<CR>', { desc = 'a line (with whitespace)' })

return M
