vim.g.mapleader = " "
vim.g.maplocalleader = " "

local M = {}

local function map(modes, key, value, options)
    -- Modes
    -- x: only visual mode
    -- s: only select mode
    -- v: both visual and select mode
    local default_options = { silent = true, noremap = true }
    options = options and vim.tbl_extend("keep", options, default_options) or default_options
    vim.keymap.set(modes, key, value, options)
end
M.map = map

map("s", "<BS>", "<C-g>s", { desc = "Delete selection" })
map("x", "y", "m`y``", { desc = "Copy selection to clipboard" })

map("i", "<C-a>", "<ESC>I", { desc = "Go to start of line" })
map("i", "<C-e>", "<ESC>A", { desc = "Go to end of line" })
map("s", "<C-a>", "<ESC>`<i", { desc = "Go to start of line" })
map("s", "<C-e>", "<ESC>`>a", { desc = "Go to end of line" })

map("n", "<CR>", "o<ESC>", { desc = "Insert blank line below" })
map("n", "<S-CR>", "O<ESC>", { desc = "Insert blank line above" })
map("n", "<C-CR>", "m`i<CR><Esc>``", { desc = "Break line at cursor" })

map("n", "i", function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local line = vim.fn.getline(".")
    ---@diagnostic disable-next-line: undefined-field
    return line:match("^%s*$") and "cc" or "i"
end, { expr = true, desc = "Correct indentation when pressing i on empty line" })

-- REFERENCE: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map("n", "<C-n>", ":move .+1<CR>==", { desc = "Move line down" })
map("n", "<C-p>", ":move .-2<CR>==", { desc = "Move line up" })
-- map("i", "<C-n>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
-- map("i", "<C-p>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("x", "<C-n>", ":move '>+1<CR>gv=gv", { desc = "Move visual selection down" })
map("x", "<C-p>", ":move '<-2<CR>gv=gv", { desc = "Move visual selection up" })

map("n", "<C-k>", "<C-w>k", { desc = "Focus top window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus bottom window" })
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

map("t", "<C-Esc>", "<C-\\><C-n>", { desc = "Escape terminal mode" })
map("t", "<C-q>", "<C-\\><C-n><C-w>c", { desc = "Close terminal" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Focus top window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Focus bottom window" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Focus left window" })
-- map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Focus right window" })

-- map("n", "<Up>", "<C-w>1+", { desc = "Grow window vertically" })
-- map("n", "<Down>", "<C-w>1-", { desc = "Shrink window vertically" })
-- map("n", "<Left>", "<C-w>5<", { desc = "Shrink window horizontally" })
-- map("n", "<Right>", "<C-w>5>", { desc = "Grow window horizontally" })

map("n", "<leader>fd", "za", { desc = "Toggle fold" })
map("n", "<leader>fD", "zA", { desc = "Toggle fold recursively" })

if vim.fn.has("mac") == 1 then
    map("n", "gx", "<CMD>!open <cfile><CR>", { desc = "Open link in browser" })
elseif vim.fn.has("unix") == 1 then
    map("n", "gx", "<CMD>!xdg-open <cfile><CR>", { desc = "Open link in browser" })
end

map("n", "<leader>cc", "<CMD>set cursorcolumn!<CR>", { desc = "Toggle cursor column" })

return M
