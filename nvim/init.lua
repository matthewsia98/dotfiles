local function map(mode, key, value, options)
    options = options or { silent = true }
    vim.keymap.set(mode, key, value, options)
end

-- VIM --
local g = vim.g
local o = vim.o
local A = vim.api

-- cmd('syntax on')
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
o.signcolumn = 'yes:1'
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
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
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

-- Status Line
Plug 'nvim-lualine/lualine.nvim'

-- Icons
Plug 'kyazdani42/nvim-web-devicons'

-- Directory Tree
Plug 'kyazdani42/nvim-tree.lua'

-- Required by Telescope
Plug 'nvim-lua/plenary.nvim'

-- Fuzzy Finder
Plug 'nvim-telescope/telescope.nvim'

-- Color Scheme
Plug('catppuccin/nvim', { as = 'catppuccin' })

-- Abstract Syntax Tree
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn[':TSUpdate'] })

-- Indent Lines
Plug 'lukas-reineke/indent-blankline.nvim'

-- Git Decorations
Plug 'lewis6991/gitsigns.nvim'

-- Preview Git Commits
Plug 'rhysd/git-messenger.vim'

-- Easily toggle and make new comments
Plug 'numToStr/Comment.nvim'

-- Visualize RGB color codes
Plug 'norcalli/nvim-colorizer.lua'

-- Easily surround text objects
Plug 'tpope/vim-surround'

-- Matching Quotes/Brackets
Plug 'windwp/nvim-autopairs'

-- Language Server
Plug 'neovim/nvim-lspconfig'

-- Language Server Manager
Plug 'williamboman/mason.nvim'

-- Pretty LSP Preview
Plug 'folke/trouble.nvim'

-- Code Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
-- Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'onsails/lspkind.nvim'

vim.call('plug#end')


-- COLOR SCHEME --
vim.g.catppuccin_flavour = 'macchiato'
local cp = require('catppuccin/palettes').get_palette()
require('catppuccin').setup {
    transparent_background = false,
    integrations = {},
    custom_highlights = {
        Comment = { fg = cp.blue },
        LineNr = { fg = cp.lavender },
        CursorLineNr = { fg = '#00FFFF' }
    }
}
vim.cmd [[colorscheme catppuccin]]


-- LUALINE --
require('lualine').setup {
    options = {
        theme = 'catppuccin',
        icons_enabled = true,
        -- powerline    
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
    },
    -- a b c                x y z
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diagnostics' }, --'branch', --'diagnostics'
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = {}, --'branch', 'diff'}
        lualine_z = { 'progress', 'location' }
    }
}


-- NVIMTREE --
map('n', '<leader>nt', ':NvimTreeToggle<CR>')
require('nvim-tree').setup {
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
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


-- TELESCOPE--
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
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
vim.cmd [[highlight IndentBlanklineChar guifg=#B7BDF8 gui=nocombine]] -- color of indent lines
vim.cmd [[highlight IndentBlanklineContextChar guifg=#ED8796 gui=nocombine]] -- color of current context indent line (vertical line)
vim.cmd [[highlight IndentBlanklineContextStart guisp=#ED8796 gui=underline]] -- color of current context start (underline)
require('indent_blankline').setup {
    show_current_context = true,
    show_current_context_start = true,
}


-- GIT SIGNS --
require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        -- Navigation
        map('n', '<leader>nh',
            function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end,
            { expr = true }
        )

        map('n', '<leader>ph',
            function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end,
            { expr = true }
        )

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end,
    signs = {
        add = {
            hl = 'GitSignsAdd',
            text = '▎',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn'
        },
        change = {
            hl = 'GitSignsChange',
            text = '▎',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
        delete = {
            hl = 'GitSignsDelete',
            text = '',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        topdelete = {
            hl = 'GitSignsDelete',
            text = '',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn'
        },
        changedelete = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
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
vim.g.git_messenger_always_into_popup = false
map('n', '<leader>gm', ':GitMessenger<CR>')


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


-- MASON LSPCONFIG --
-- require('mason-lspconfig').setup()


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
-- Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local lsp_opts = { noremap = true, silent = true }
map('n', '<leader>d', vim.diagnostic.open_float, lsp_opts)
map('n', '<leader>pd', vim.diagnostic.goto_prev, lsp_opts)
map('n', '<leader>nd', vim.diagnostic.goto_next, lsp_opts)
map('n', '<leader>q', vim.diagnostic.setloclist, lsp_opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'H', vim.lsp.buf.hover, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', '<leader>s', vim.lsp.buf.signature_help, bufopts)
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    map('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
        bufopts
    )
    map('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
    map('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = true,
        virtual_text = true,
        signs = false,
    }
    ),
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)


-- PYTHON LSP --
--[[ require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    handlers = handlers,
} ]]
require('lspconfig')['pylsp'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    handlers = handlers,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = false,
                },
                mccabe = {
                    enabled = false,
                },
                flake8 = {
                    enabled = true,
                    ignore = {
                        'E501', -- Line too long
                        'E266', -- Too many leading # for block comment
                    }
                },
                black = {
                    enabled = true,
                    max_line_length = 88,
                    preview = true,
                },
                mypy = {
                    enabled = true,
                    live_mode = true,
                    strict = false,
                },
                rope = {
                    enabled = true,
                },
                isort = {
                    enabled = true,
                }
            }
        }
    }
}


-- LUA LSP --
require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    handlers = handlers,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}


-- JAVA LSP --
require('lspconfig')['jdtls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    handlers = handlers,
    capabilities = capabilities,
}


-- NVIM CMP --
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Scrollbar
vim.cmd [[highlight PmenuThumb guibg=#C5CDD9 guifg=NONE]]

-- Prompt Menu
vim.cmd [[highlight CmpPmenu guibg=#22252A guifg=#C5CDD9]]
vim.cmd [[highlight CmpPmenuSel guibg=#282C34 guifg=NONE]]

-- Completion Items
vim.cmd [[highlight CmpItemAbbrDeprecated guibg=NONE guifg=#7E8294 gui=strikethrough]]
vim.cmd [[highlight CmpItemAbbrMatch guibg=NONE guifg=#82AAFF gui=bold]]
vim.cmd [[highlight CmpItemAbbrMatchFuzzy guibg=NONE guifg=#82AAFF gui=bold]]
vim.cmd [[highlight CmpItemMenu guibg=NONE guifg=#C792EA gui=italic]]
vim.cmd [[highlight CmpItemKindField guibg=#B5585F guifg=#EED8DA]]
vim.cmd [[highlight CmpItemKindProperty guibg=#B5585F guifg=#EED8DA]]
vim.cmd [[highlight CmpItemKindEvent guibg=#B5585F guifg=#EED8DA]]
vim.cmd [[highlight CmpItemKindText guibg=#9FBD73 guifg=#C3E88D]]
vim.cmd [[highlight CmpItemKindEnum guibg=#9FBD73 guifg=#C3E88D]]
vim.cmd [[highlight CmpItemKindKeyword guibg=#9FBD73 guifg=#C3E88D]]
vim.cmd [[highlight CmpItemKindConstant guibg=#D4BB6C guifg=#FFE082]]
vim.cmd [[highlight CmpItemKindConstructor guibg=#D4BB6C guifg=#FFE082]]
vim.cmd [[highlight CmpItemKindReference guibg=#D4BB6C guifg=#FFE082]]
vim.cmd [[highlight CmpItemKindFunction guibg=#A377BF guifg=#EADFF0]]
vim.cmd [[highlight CmpItemKindStruct guibg=#A377BF guifg=#EADFF0]]
vim.cmd [[highlight CmpItemKindClass guibg=#A377BF guifg=#EADFF0]]
vim.cmd [[highlight CmpItemKindModule guibg=#A377BF guifg=#EADFF0]]
vim.cmd [[highlight CmpItemKindOperator guibg=#A377BF guifg=#EADFF0]]
vim.cmd [[highlight CmpItemKindVariable guibg=#7E8294 guifg=#C5CDD9]]
vim.cmd [[highlight CmpItemKindFile guibg=#7E8294 guifg=#C5CDD9]]
vim.cmd [[highlight CmpItemKindUnit guibg=#D4A959 guifg=#F5EBD9]]
vim.cmd [[highlight CmpItemKindSnippet guibg=#D4A959 guifg=#F5EBD9]]
vim.cmd [[highlight CmpItemKindFolder guibg=#D4A959 guifg=#F5EBD9]]
vim.cmd [[highlight CmpItemKindMethod guibg=#6C8ED4 guifg=#DDE5F5]]
vim.cmd [[highlight CmpItemKindValue guibg=#6C8ED4 guifg=#DDE5F5]]
vim.cmd [[highlight CmpItemKindEnumMember guibg=#6C8ED4 guifg=#DDE5F5]]
vim.cmd [[highlight CmpItemKindInterface guibg=#58B5A8 guifg=#D8EEEB]]
vim.cmd [[highlight CmpItemKindColor guibg=#58B5A8 guifg=#D8EEEB]]
vim.cmd [[highlight CmpItemKindTypeParameter guibg=#58B5A8 guifg=#D8EEEB]]

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local luasnip = require('luasnip')
local cmp = require('cmp')
local lspkind = require('lspkind')
if cmp ~= nil then
    cmp.setup(
        {
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    local kind = lspkind.cmp_format(
                        {
                            mode = 'symbol_text',
                            maxwidth = 50,
                            menu = ({
                                buffer = '[Buffer]',
                                nvim_lsp = '[LSP]',
                                luasnip = '[LuaSnip]',
                                nvim_lua = '[Lua]',
                                latex_symbols = '[Latex]'
                            })
                        }
                    )(entry, vim_item)
                    local strings = vim.split(kind.kind, '%s', { trimempty = true })
                    if strings[1] ~= nil then
                        kind.kind = ' ' .. strings[1] .. ' '
                    end
                    if strings[2] ~= nil then
                        kind.menu = '    (' .. strings[2] .. ')'
                    end

                    return kind
                end,
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                end,
            },
            window = {
                completion = {
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenu,Search:None',
                    col_offset = -3,
                    side_padding = 0,
                }
                -- documentation = cmp.config.window.bordered(),
            },
            view = {
                entries = {
                    name = 'custom',
                    selection_order = 'near_cursor'
                }
            },
            mapping = cmp.mapping.preset.insert(
                {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                          cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                          luasnip.expand_or_jump()
                        elseif has_words_before() then
                          cmp.complete()
                        else
                          fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                          cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                          luasnip.jump(-1)
                        else
                          fallback()
                        end
                    end, { "i", "s" }),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }
            ),
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                },
                {
                    { name = 'buffer' },
                }
            )
        }
    )

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit',
        {
            sources = cmp.config.sources(
                {
                    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                },
                {
                    { name = 'buffer' },
                }
            )
        }
    )

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    }
    )

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':',
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    { name = 'path' }
                },
                {
                    { name = 'cmdline' }
                }
            )
        }
    )
end


-- TROUBLE --
map("n", "<leader>wd", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>dd", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>ll", "<cmd>TroubleToggle loclist<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>qf", "<cmd>TroubleToggle quickfix<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>gr", "<cmd>TroubleToggle lsp_references<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>gt", "<cmd>TroubleToggle lsp_type_definitions<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>gi", "<cmd>TroubleToggle lsp_implementations<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>gd", "<cmd>TroubleToggle lsp_definitions<cr>",
    { silent = true, noremap = true }
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
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
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
-- Go to start and end of line
map('i', '<C-E>', '<Esc>A')
map('n', '<C-E>', 'A<Esc>')
map('i', '<C-A>', '<Esc>I')
map('n', '<C-A>', 'I<Esc>')
-- Insert blank lines
map('n', '<CR>', 'o<Esc>')
map('n', '<S-CR>', 'O<Esc>')
-- Move Lines
map('n', '<C-j>', ':move .+1<CR>')
map('n', '<C-k>', ':move .-2<CR>')
-- Window Splits
map('n', '<leader>wv', '<C-w>v')
map('n', '<leader>ws', '<C-w>s')
map('n', '<leader>wc', '<C-w>c')
map('n', '<leader>wh', '<C-w>h')
map('n', '<leader>wl', '<C-w>l')
map('n', '<leader>wj', '<C-w>j')
map('n', '<leader>wk', '<C-w>k')
