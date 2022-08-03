-- VIM OPTIONS --
local g = vim.g
local o = vim.o
local A = vim.api

--cmd('syntax on')
A.nvim_command('filetype plugin indent on')

o.termguicolors = true
-- o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 1000
o.updatetime = 200

-- Enable mouse
o.mouse = 'a'

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.numberwidth = 6
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true

-- Better editing experience
o.expandtab = true
-- o.smarttab = true
-- o.cindent = true
-- o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'lead:·,trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂,'
--o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
-- o.jumpoptions = 'view'

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

-- AUTOCMD --
-- Prevent newline from starting as comment
A.nvim_create_autocmd('BufEnter',
                      {
                          callback = function()
                                        o.formatoptions = string.gsub(o.formatoptions, '[cro]', '')
                                     end
					  }
			         )

-- Highlight yanked region
A.nvim_create_autocmd('TextYankPost',
                      {
                          callback = function()
                                        vim.highlight.on_yank({ higroup = 'Visual', timeout = 3000 })
                                     end
                      }
                     )

-- PLUGINS --
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug('preservim/nerdtree', {on = {'NERDTreeToggle'}})
Plug('nvim-lualine/lualine.nvim')
Plug('kyazdani42/nvim-web-devicons')
Plug('catppuccin/nvim', {as = 'catppuccin'})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})
Plug('lukas-reineke/indent-blankline.nvim')
Plug('lewis6991/gitsigns.nvim')
Plug('rhysd/git-messenger.vim')
Plug('numToStr/Comment.nvim')
Plug('norcalli/nvim-colorizer.lua')
Plug('tpope/vim-surround')
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('windwp/nvim-autopairs')
vim.call('plug#end')

-- COLOR SCHEME --
vim.g.catppuccin_flavour = 'macchiato'
local cp = require('catppuccin/palettes').get_palette()
require('catppuccin').setup({
                                transparent_background = false,
                                integrations = {},
                                custom_highlights = {
                                                        Comment = {fg = cp.blue},
                                                        LineNr = {fg = cp.lavender},
                                                        CursorLineNr = {fg = '#00FFFF'}
                                                    }
                            }
                           )
vim.cmd [[colorscheme catppuccin]]

-- LUALINE --
require('lualine').setup({
                             options = {
                                           theme = 'catppuccin',
                                           icons_enabled = true,
                                           -- powerline    
                                           section_separators = {left = '', right = ''},
                                           component_separators = {left = '', right = ''}
                                       },
                             -- a b c                x y z
                             sections = {
                                            lualine_a = {'mode'},
                                            lualine_b = {}, --'branch', --'diagnostics'
                                            lualine_c = {'filename'},
                                            lualine_x = {'encoding', 'fileformat', 'filetype'},
                                            lualine_y = {}, --'branch', 'diff'}
                                            lualine_z = {'progress', 'location'}
                                        }
                         }
                        )

-- TREESITTER --
require('nvim-treesitter.configs').setup {
                                            highlight = {
                                                            enable = true,
                                                            additional_vim_regex_highlighting = false,
                                                        },
                                         }

-- INDENT BLANKLINE --
-- color of indent lines
vim.cmd [[highlight IndentBlanklineChar guifg=#B7BDF8 gui=nocombine]]
-- color of current context indent line (vertical line)
vim.cmd [[highlight IndentBlanklineContextChar guifg=#ED8796 gui=nocombine]]
-- color of current context start (underline)
vim.cmd [[highlight IndentBlanklineContextStart guisp=#ED8796 gui=underline]]
require('indent_blankline').setup {
                                      show_current_context = true,
                                      show_current_context_start = true,
                                  }

-- GIT SIGNS --

-- GIT MESSENGER --
vim.g.git_messenger_no_default_mappings = true
vim.g.git_messenger_always_into_popup = true

-- COMMENT PLUGIN --
require('Comment').setup({
                            toggler = {
                                          line = 'gcc',
                                          block = 'gbc',
                            },

                            opleader = {
                                           line = 'gc',
                                           block = 'gb',
                            },

                            extra = {
                                        above = 'gcO',
                                        below = 'gco',
                                        eol = 'gcA',
                            },
                         }
                        )

-- COLORIZER --
require('colorizer').setup()

-- LSP CONFIG --
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
                      -- Enable completion triggered by <c-x><c-o>
                      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                      -- Mappings.
                      -- See `:help vim.lsp.*` for documentation on any of the below functions
                      local bufopts = { noremap=true, silent=true, buffer=bufnr }
                      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                      vim.keymap.set('n', 'H', vim.lsp.buf.hover, bufopts)
                      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                      vim.keymap.set('n', '<leader>s', vim.lsp.buf.signature_help, bufopts)
                      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                      vim.keymap.set('n', '<leader>wl', 
                                     function()
                                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                                     end, bufopts)
                      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
                      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
                      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
                      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                      vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
                  end

local lsp_flags = {
    debounce_text_changes = 150,
}

require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

-- MASON --
require('mason').setup({

                       }
                      )

-- AUTOPAIRS --
require('nvim-autopairs').setup()

-- KEY BINDINGS --
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

--  mode   key      value
map('i', '<C-E>', '<Esc>A')
map('n', '<C-E>', 'A<Esc>')
map('i', '<C-A>', '<Esc>I')
map('n', '<C-A>', 'I<Esc>')
map('n', '<CR>', 'o<Esc>')
map('n', '<S-CR>', 'O<Esc>')
map('n', '<C-j>', ':move .+1<CR>')
map('n', '<C-k>', ':move .-2<CR>')
map('n', '<leader>nt', ':NERDTreeToggle<CR>')
map('n', '<leader>gm', ':GitMessenger<CR>')
map('n', '<leader>wv', '<C-w>v')
map('n', '<leader>ws', '<C-w>s')
map('n', '<leader>wc', '<C-w>c')
map('n', '<leader>wh', '<C-w>h')
map('n', '<leader>wl', '<C-w>l')
map('n', '<leader>wj', '<C-w>j')
map('n', '<leader>wk', '<C-w>k')
