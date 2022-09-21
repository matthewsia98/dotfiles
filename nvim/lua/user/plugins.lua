local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local packer_installed, packer = pcall(require, "packer")
if not packer_installed then
    return
end

-- Automatically run :PackerSync whenever plugins.lua is updated
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    callback = function()
        vim.cmd [[source %]]
        vim.cmd [[PackerCompile]]
        vim.cmd [[PackerSync]]
    end
})

packer.startup({function(use)
    -- Package Manager --
    use 'wbthomason/packer.nvim'

    -- Required Plugins --
    use 'nvim-lua/plenary.nvim'

    use {
        'rcarriga/nvim-notify',
        config = function()
            require('user.plugins.nvim-notify')
        end,
    }

    use {
        'folke/which-key.nvim',
        config = function()
            require('user.plugins.which-key')
        end,
    }

    -- Theme, Icons, Statusbar, Bufferbar --
    use {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require('user.plugins.nvim-web-devicons')
        end
    }

    use {
        'catppuccin/nvim',
        event = 'BufEnter',
        run = ':CatppuccinCompile',
        config = function()
            require('user.plugins.catppuccin')
        end,
        as = 'catppuccin'
    }

    use {
        'akinsho/bufferline.nvim',
        after = 'catppuccin',
        config = function()
            require('user.plugins.bufferline')
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        after = 'catppuccin',
        config = function()
            require('user.plugins.lualine')
        end,
    }

    -- Treesitter --
    use {
        'nvim-treesitter/nvim-treesitter',
        event = "CursorHold",
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        requires = {
            { "nvim-treesitter/playground", after = "nvim-treesitter" },
            { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
            {
                "nvim-treesitter/nvim-treesitter-context",
                after = "nvim-treesitter",
                config = function()
                    require('user.plugins.treesitter-context')
                end
            },
        },
        config = function()
            require('user.plugins.treesitter')
        end,
    }

    -- Navigation and Fuzzy Search --
    use {
        'kyazdani42/nvim-tree.lua',
        event = 'CursorHold',
        config = function()
            require('user.plugins.nvim-tree')
        end,
    }

    use {
        'folke/trouble.nvim',
        event = 'CursorHold',
        config = function()
            require('user.plugins.trouble')
        end,
    }

    use {
        'nvim-telescope/telescope.nvim',
        after = 'trouble.nvim',
        requires = {
            {
                "nvim-telescope/telescope-ui-select.nvim",
                after = 'telescope.nvim',
                config = function()
                    local installed, telescope = pcall(require, 'telescope')
                    if installed then
                        telescope.load_extension('ui-select')
                    end
                end,
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                after = 'telescope.nvim',
                run = "make",
                config = function()
                    local installed, telescope = pcall(require, 'telescope')
                    vim.defer_fn(function()
                        if installed then
                            telescope.load_extension('fzf')
                        end
                    end, 10000)
                end,
            },
        },
        config = function()
            require('user.plugins.telescope')
        end,
    }

    use {
        'karb94/neoscroll.nvim',
        event = 'WinScrolled',
        config = function()
            require('user.plugins.neoscroll')
        end,
    }

    -- Visuals --
    use {
        'norcalli/nvim-colorizer.lua',
        event = 'CursorHold',
        config = function()
            require('user.plugins.nvim-colorizer')
        end,
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        -- event = 'BufRead',
        after = 'nvim-treesitter',
        config = function()
            require('user.plugins.indent-blankline')
        end,
    }

    -- Editing --
    use {
        'numToStr/Comment.nvim',
        event = 'BufRead',
        config = function()
            require('user.plugins.Comment')
        end,
    }

    use {
        'kylechui/nvim-surround',
        event = 'BufRead',
        config = function()
            require('user.plugins.nvim-surround')
        end,
    }

    use {
        'windwp/nvim-autopairs',
        event = 'InsertCharPre',
        after = 'nvim-cmp',
        config = function()
            require('user.plugins.nvim-autopairs')
        end,
    }

    -- Git --
    use {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('user.plugins.gitsigns')
        end,
    }

    use {
        'rhysd/git-messenger.vim',
        event = 'BufRead',
        config = function()
            require('user.plugins.git-messenger')
        end,
    }

    -- Terminal --
    use {
        'akinsho/toggleterm.nvim',
        event = 'CursorHold',
        config = function()
            require('user.plugins.toggleterm')
        end,
    }

    -- LSP, Completions and Snippets --
    use {
        'hrsh7th/nvim-cmp',
        -- event = 'CmdlineEnter',
        after = 'LuaSnip',
        requires = {
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'onsails/lspkind.nvim' },
            {
                'L3MON4D3/LuaSnip',
                event = { 'InsertEnter', 'CmdlineEnter' },
                requires = { 'rafamadriz/friendly-snippets' },
                config = function()
                    require('user.plugins.lsp.luasnip')
                end,
            },
        },
        config = function() require('user.plugins.lsp.nvim-cmp') end,
    }

    use {
        'williamboman/mason.nvim',
        event = 'BufRead',
        requires = {
            {
                "williamboman/mason-lspconfig.nvim",
                after = 'mason.nvim',
                config = function()
                    require('user.plugins.lsp.mason-lspconfig')
                end,
            },
            { 'neovim/nvim-lspconfig',
                after = 'mason-lspconfig.nvim',
                requires = {
                    'hrsh7th/cmp-nvim-lsp'
                },
                config = function()
                    require('user.plugins.lsp.nvim-lspconfig')
                    require('user.plugins.lsp')
                end,
            },
        },
        config = function()
            require('user.plugins.lsp.mason')
            vim.schedule(function()
                local exists = vim.fn.isdirectory(vim.fn.expand('~/.local/share/nvim/mason'))
                if exists == 0 then
                    vim.cmd [[MasonInstall python-lsp-server black flake8 isort mypy]]
                    vim.cmd [[MasonInstall lua-language-server luacheck stylua]]
                    vim.cmd [[MasonInstall jdtls]]
                end
            end)
        end,
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'BufRead',
        config = function()
            require('user.plugins.lsp.null-ls')
            require('user.plugins.lsp')
        end,
    }

    -- use {
    --     'dccsillag/magma-nvim',
    --     event = 'BufRead',
    --     run = ':UpdateRemotePlugins',
    --     config = function()
    --         require('user.plugins.magma-nvim')
    --     end
    -- }

    use {
        '~/.config/nvim/my-plugins/python-docstring-generator.nvim',
        after = 'nvim-treesitter',
        config = function()
            require('user.plugins.python-docstring-generator')
        end,
    }

    if packer_bootstrap then
        packer.sync()
    end
end,
config = {
    profile = {
        enable = true,
        threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end
    }
}})
