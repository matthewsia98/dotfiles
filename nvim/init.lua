local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

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
o.signcolumn = 'auto:3'
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
Plug('nvim-lualine/lualine.nvim')
Plug('kyazdani42/nvim-web-devicons')
-- Plug('preservim/nerdtree', {on = {'NERDTreeToggle'}})
Plug('kyazdani42/nvim-tree.lua')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
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
Plug('folke/trouble.nvim')
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
                                            lualine_b = {'diagnostics'}, --'branch', --'diagnostics'
                                            lualine_c = {'filename'},
                                            lualine_x = {'encoding', 'fileformat', 'filetype'},
                                            lualine_y = {}, --'branch', 'diff'}
                                            lualine_z = {'progress', 'location'}
                                        }
                         }
                        )

-- NVIMTREE --
require('nvim-tree').setup(
    {
        sort_by = "case_sensitive",
        view = {
            adaptive_size = true,
            mappings = {
                list = {
                    {
                        key = "u", action = "dir_up"
                    },
                },
            },
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    }
)

-- TELESCOPE--
map('n','<leader>ff', '<cmd>Telescope find_files<cr>')
map('n','<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n','<leader>fb', '<cmd>Telescope buffers<cr>')
map('n','<leader>fh', '<cmd>Telescope help_tags<cr>')
require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}

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
require('gitsigns').setup {
    on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                      opts = opts or {}
                      opts.buffer = bufnr
                      vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']h', function()
                                       if vim.wo.diff then return ']c' end
                                       vim.schedule(function() gs.next_hunk() end)
                                       return '<Ignore>'
                                   end, {expr=true}
                    )

                    map('n', '[h', function()
                                       if vim.wo.diff then return '[c' end
                                       vim.schedule(function() gs.prev_hunk() end)
                                       return '<Ignore>'
                                   end, {expr=true}
                    )

                    -- Actions
                    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>hS', gs.stage_buffer)
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    map('n', '<leader>hR', gs.reset_buffer)
                    map('n', '<leader>hp', gs.preview_hunk)
                    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                    map('n', '<leader>tb', gs.toggle_current_line_blame)
                    map('n', '<leader>hd', gs.diffthis)
                    map('n', '<leader>hD', function() gs.diffthis('~') end)
                    map('n', '<leader>td', gs.toggle_deleted)

                    -- Text object
                    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end,
    signs = {
                add = {
                    hl = 'GitSignsAdd',
                    text = '▎',
                    numhl='GitSignsAddNr',
                    linehl='GitSignsAddLn'
                },
                change = {
                    hl = 'GitSignsChange',
                    text = '▎',
                    numhl='GitSignsChangeNr',
                    linehl='GitSignsChangeLn'
                },
                delete = {
                    hl = 'GitSignsDelete',
                    -- text = '_',
                    text = '',
                    numhl='GitSignsDeleteNr',
                    linehl='GitSignsDeleteLn'
                },
                topdelete = {
                    hl = 'GitSignsDelete',
                    -- text = '‾',
                    text = '',
                    numhl='GitSignsDeleteNr',
                    linehl='GitSignsDeleteLn'
                },
                changedelete = {
                    hl = 'GitSignsChange',
                    text = '~',
                    numhl='GitSignsChangeNr',
                    linehl='GitSignsChangeLn'
                },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm = {
        enable = false
    },
}

-- GIT MESSENGER --
vim.g.git_messenger_no_default_mappings = true
vim.g.git_messenger_always_into_popup = true
-- q 	Close the popup window
-- o 	older. Back to older commit at the line
-- O 	Opposite to o. Forward to newer commit at the line
-- d 	Toggle unified diff hunks only in current file of the commit
-- D 	Toggle all unified diff hunks of the commit
-- r 	Toggle word diff hunks only in current file of the commit
-- R 	Toggle all word diff hunks of current commit
-- ? 	Show mappings help

-- COMMENT PLUGIN --
require('Comment').setup({
                            padding = true,
                            sticky = true,
                            ignore = nil,
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
vim.fn.sign_define(
  "DiagnosticSignError",
  { texthl = "DiagnosticSignError", text = "❌", numhl = "DiagnosticSignError" }
)
vim.fn.sign_define(
  "DiagnosticSignWarn",
  { texthl = "DiagnosticSignWarn", text = "", numhl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
  "DiagnosticSignHint",
  { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" }
)
vim.fn.sign_define(
  "DiagnosticSignInfo",
  { texthl = "DiagnosticSignInfo", text = "🛈", numhl = "DiagnosticSignInfo" }
)
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
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

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
       vim.lsp.diagnostic.on_publish_diagnostics, {
           virtual_text = true,
           signs = false,
       }
    ),
}

-- PYTHON LSP --
require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    handlers = handlers,
}

-- LUA LSP --
require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    handlers = handlers,
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'}
            }
        }
    }
}

-- MASON --
require('mason').setup(
    {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            },
            keymaps = {
                -- Keymap to expand a package
                toggle_package_expand = "<CR>",
                -- Keymap to install the package under the current cursor position
                install_package = "i",
                -- Keymap to reinstall/update the package under the current cursor position
                update_package = "u",
                -- Keymap to check for new version for the package under the current cursor position
                check_package_version = "c",
                -- Keymap to update all installed packages
                update_all_packages = "U",
                -- Keymap to check which installed packages are outdated
                check_outdated_packages = "C",
                -- Keymap to uninstall a package
                uninstall_package = "X",
                -- Keymap to cancel a package installation
                cancel_installation = "<C-c>",
                -- Keymap to apply language filter
                apply_language_filter = "<C-f>",
            },
        }
    }
)

-- TROUBLE --
-- Lua
vim.api.nvim_set_keymap("n", "<leader>wd", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>qf", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>gr", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>TroubleToggle lsp_type_definitions<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>gi", "<cmd>TroubleToggle lsp_implementations<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>TroubleToggle lsp_definitions<cr>",
  {silent = true, noremap = true}
)
require('trouble').setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

-- AUTOPAIRS --
require('nvim-autopairs').setup()

-- KEY BINDINGS --

--  mode   key      value
map('i', '<C-E>', '<Esc>A')
map('n', '<C-E>', 'A<Esc>')
map('i', '<C-A>', '<Esc>I')
map('n', '<C-A>', 'I<Esc>')
map('n', '<CR>', 'o<Esc>')
map('n', '<S-CR>', 'O<Esc>')
map('n', '<C-j>', ':move .+1<CR>')
map('n', '<C-k>', ':move .-2<CR>')
-- map('n', '<leader>nt', ':NERDTreeToggle<CR>')
map('n', '<leader>nt', ':NvimTreeToggle<CR>')
map('n', '<leader>gm', ':GitMessenger<CR>')
map('n', '<leader>wv', '<C-w>v')
map('n', '<leader>ws', '<C-w>s')
map('n', '<leader>wc', '<C-w>c')
map('n', '<leader>wh', '<C-w>h')
map('n', '<leader>wl', '<C-w>l')
map('n', '<leader>wj', '<C-w>j')
map('n', '<leader>wk', '<C-w>k')
