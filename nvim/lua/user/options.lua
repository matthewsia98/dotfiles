local g = vim.g
local o = vim.opt

g.python3_host_prog = vim.fn.expand('~/.virtualenvs/nvim/bin/python')

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

-- Enable RGB colors
o.termguicolors = true

-- Don't show -- MODE --
o.showmode = false

-- Don't show conceal on cursor line in these modes
o.concealcursor = 'nvi'
-- Don't conceal
o.conceallevel = 0

-- Time to wait for keymap
o.timeoutlen = 500
-- Time for CursorHold
o.updatetime = 200

-- Enable mouse
o.mouse = 'a'

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 12

-- Line numbers
o.number = true
o.relativenumber = true

-- Sign column
o.signcolumn = 'yes:1'

-- Highlight text on cursor line
o.cursorline = true

-- Text wrap
o.wrap = false
o.textwidth = 127

-- Tabs
o.expandtab = true
o.tabstop = 4
o.shiftround = true -- Round indent to multiple of shiftwidth when indenting with > and <
o.shiftwidth = 0 -- If 0, tabstop value if used
o.softtabstop = -1 -- If negative, shiftwidth value is used

o.list = true
o.listchars = 'lead:·,trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Search
o.ignorecase = true -- \c to ignore case, \C to match case
o.smartcase = true -- Automatically match case if Capital letters are present

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Only 1 global statusline
o.laststatus = 3

-- Code Folding
o.foldenable = false
-- o.foldmethod = 'expr'
-- o.foldexpr = 'nvim_treesitter#foldexpr()'
-- o.foldlevelstart = 99 -- Don't fold by default
-- o.foldlevel = 99 -- Don't fold by default
-- o.foldnestmax = 3
-- o.foldminlines = 1

-- Set window title
vim.o.titlestring = '%t'
o.title = true

-- Format Options
vim.cmd [[filetype plugin off]]
-- t: Auto-wrap using textwidth
-- c: Auto-wrap comments using textwidth and insert comment leader automatically
-- r: BAD!!! Automatically insert comment leader when hitting <Enter> in Insert mode
-- o: BAD!!! Automatically insert comment leader when hitting o/O in Normal mode
-- n: Recognize numbered lists
-- l: Long lines are not broken in insert mode
-- j: Remove comment leader when joining lines
-- p: Don't break lines at single spaces that follow periods e.g. Mr. John
vim.o.formatoptions = 'tcnjp'
