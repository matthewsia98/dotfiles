local o = vim.o
local opt = vim.opt

-- Assign python3 virtualenv for Neovim
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/nvim/bin/python")

-- Makes neovim and host OS clipboard play nicely with each other
opt.clipboard = "unnamedplus"

-- Enable 24 bit RGB colors. Use gui highlight attributes instead of cterm attributes
opt.termguicolors = true

-- Enable mouse
opt.mouse = "a"

-- Number of screen lines to use for the command-line
opt.cmdheight = 0

-- Don't show -- MODE --
opt.showmode = false

-- Show line numbers
opt.number = true
opt.relativenumber = true

-- Highlight cursor line
opt.cursorline = true

-- Ignore case in search patterns. \c to ignore case, \C to match case
opt.ignorecase = true
-- Automatically match case if Capital letters are present
opt.smartcase = true

-- When on, splitting a window will put the new window right of the current one
opt.splitright = true
-- When on, splitting a window will put the new window below the current one
opt.splitbelow = true

-- Minimum number of screen lines to keep above and below the cursor
o.scrolloff = math.floor(vim.o.lines / 2)

opt.smartindent = true
-- Replace <TAB> with appropriate number of spaces in INSERT mode
opt.expandtab = true
-- Round indent to multiple of shiftwidth
opt.shiftround = true
-- Number of spaces that a <Tab> in the file counts for
opt.tabstop = 4
-- Number of spaces to use for each step of (auto)indent
opt.shiftwidth = 0 -- If 0, tabstop value if used
-- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
opt.softtabstop = -1 -- If negative, shiftwidth value is used

opt.foldcolumn = "1"
opt.foldlevelstart = 99
opt.foldlevel = 99
opt.foldnestmax = 3
opt.foldminlines = 1

opt.list = true
o.listchars = "lead:·,trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"
o.fillchars = "eob: ,fold: ,foldsep: ,foldopen:,foldclose:"

-- Command line completion mode
opt.wildmode = "longest:full,full"
-- Enable fuzzy matching for commands
opt.wildoptions = "fuzzy,pum,tagfile"

opt.undofile = true
opt.swapfile = false

-- Time in milliseconds to wait for a mapped sequence to complete
opt.timeoutlen = 500
-- Time in milliseconds for CursorHold
opt.updatetime = 200

-- Always show tabline
opt.showtabline = 2
-- Only 1 global statusline
opt.laststatus = 3

-- Sign column with max width of 2 (gitsigns and diagnostics)
-- opt.signcolumn = "yes:2"
opt.statuscolumn = [[%!v:lua.require("statuscolumn").get()]]

-- Enable spell check
opt.spell = true
-- When a word is CamelCased, assume "Cased" is a separate word
opt.spelloptions = "camel"
-- Don't check if words should start with Capital letters
opt.spellcapcheck = ""
o.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
