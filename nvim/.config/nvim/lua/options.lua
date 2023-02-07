local o = vim.o
local opt = vim.opt

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/nvim/bin/python")

-- Makes neovim and host OS clipboard play nicely with each other
opt.clipboard = "unnamedplus"

-- Enable 24 bit RGB colors
opt.termguicolors = true

opt.cmdheight = 0
opt.showmode = false

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

o.scrolloff = math.floor(vim.o.lines / 2)

opt.expandtab = true
opt.shiftround = true
opt.tabstop = 4
opt.shiftwidth = 0
opt.softtabstop = -1

opt.foldcolumn = "1"
opt.foldlevelstart = 99
opt.foldlevel = 99
opt.foldnestmax = 3
opt.foldminlines = 1

opt.list = true
o.listchars = "lead:·,trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"
o.fillchars = "eob: ,fold: ,foldsep: ,foldopen:,foldclose:"

opt.undofile = true
opt.swapfile = false

-- Time to wait for keymap
opt.timeoutlen = 500
-- Time for CursorHold
opt.updatetime = 200

opt.laststatus = 3

opt.signcolumn = "yes:2"
opt.statuscolumn = [[%!v:lua.require("statuscolumn").column()]]

opt.spell = true
opt.spelloptions = "camel"
o.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
