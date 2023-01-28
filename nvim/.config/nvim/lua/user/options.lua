local g = vim.g
local o = vim.o
local opt = vim.opt

g.python3_host_prog = vim.fn.expand("~/.virtualenvs/nvim/bin/python")

-- Map <leader> to space
g.mapleader = " "
g.maplocalleader = " "

-- Enable spell check
opt.spell = true
opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")

-- Enable RGB colors
opt.termguicolors = true

-- Don't show -- MODE --
opt.showmode = false

-- Set commandline height
opt.cmdheight = 0

-- Disable builtin completion menu
opt.completeopt = ""

-- Disable commandline completion
opt.wildmenu = false

-- Get rid of t flag. Prevents < message
opt.shortmess = "filnxToOF"

-- Get rid of _. Make _ a word boundary
-- opt.iskeyword = "@,48-57,192-255"

-- Disable conceal on cursor line in these modes
opt.concealcursor = "nvi"
-- Don't conceal
opt.conceallevel = 0

-- Time to wait for keymap
opt.timeoutlen = 500
-- Time for CursorHold
opt.updatetime = 200

-- Enable mouse
opt.mouse = "a"

-- Minimum number of screen lines to keep above and below the cursor
opt.scrolloff = math.floor(vim.o.lines / 2)

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Sign column with max width of 1
opt.signcolumn = "yes:2"

-- Highlight cursor line
opt.cursorline = true

-- Text wrap
opt.wrap = true
-- opt.textwidth = vim.o.columns - vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff

-- Indent
opt.autoindent = false
opt.cindent = false
opt.smartindent = false

-- Tabs
opt.expandtab = true
opt.tabstop = 4
opt.shiftround = true -- Round indent to multiple of shiftwidth when indenting with > and <
opt.shiftwidth = 0 -- If 0, tabstop value if used
opt.softtabstop = -1 -- If negative, shiftwidth value is used

opt.list = true
opt.listchars = "lead:·,trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- Makes neovim and host OS clipboard play nicely with each other
opt.clipboard = "unnamedplus"

-- Search
opt.ignorecase = true -- \c to ignore case, \C to match case
opt.smartcase = true -- Automatically match case if Capital letters are present

-- Undo and backup options
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.swapfile = false

-- Remember 50 items in commandline history
opt.history = 50

-- Better buffer splitting
opt.splitright = true
opt.splitbelow = true

-- Only 1 global statusline
opt.laststatus = 3

-- opt.statuscolumn = ""

-- Code Folding
opt.foldenable = true
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldcolumn = "0"
opt.foldlevelstart = 99 -- Don't fold by default
opt.foldlevel = 99 -- Don't fold by default
opt.foldnestmax = 3
opt.foldminlines = 1

-- Set window title
-- opt.titlestring = '%t'
-- opt.title = true

-- Disable sourcing of /usr/local/share/nvim/runtime/ftplugin/ files (Affects formatoptions)
vim.cmd([[filetype plugin off]])
-- Enable sourcing of /usr/local/share/nvim/runtime/indent/ files
vim.cmd([[filetype indent on]])

-- Format Options
-- t: Auto-wrap using textwidth
-- c: Auto-wrap comments using textwidth and insert comment leader automatically
-- r: BAD!!! Automatically insert comment leader when hitting <Enter> in Insert mode
-- o: BAD!!! Automatically insert comment leader when hitting o/O in Normal mode
-- n: Recognize numbered lists
-- l: Long lines are not broken in insert mode
-- j: Remove comment leader when joining lines
-- p: Don't break lines at single spaces that follow periods e.g. Mr. John
o.formatoptions = "tcnjp"
