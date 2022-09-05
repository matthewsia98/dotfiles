local packer = require('packer')
local use = packer.use

return packer.startup(function()
    use {
        'wbthomason/packer.nvim',
        opt = false,
    }

    use {
        '~/.config/nvim/my-plugins/python-docstring-generator.nvim',
        config = function() require('plugins.python-docstring-generator') end,
    }

    use {
        'catppuccin/nvim',
        config = function() require('plugins.catppuccin') end,
        as = 'catppuccin'
    }

    use 'kyazdani42/nvim-web-devicons'

    use {
        'rcarriga/nvim-notify',
        config = function() require('plugins.nvim-notify') end,
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('plugins.nvim-colorizer') end,
    }

    use {
        'numToStr/Comment.nvim',
        config = function() require('plugins.Comment') end,
    }

    use {
        'kylechui/nvim-surround',
        config = function() require('plugins.nvim-surround') end,
    }
    use {
        'windwp/nvim-autopairs',
        config = function() require('plugins.nvim-autopairs') end,
    }

    use {
        'akinsho/bufferline.nvim',
        config = function() require('plugins.bufferline') end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        config = function() require('plugins.lualine') end,
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('plugins.indent-blankline')
        end,
    }

    use {
        'karb94/neoscroll.nvim',
        config = function() require('plugins.neoscroll') end,
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('plugins.gitsigns') end,
    }
    use {
        'rhysd/git-messenger.vim',
        config = function() require('plugins.git-messenger') end,
    }
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('plugins.nvim-tree') end,
    }
    use 'nvim-lua/plenary.nvim'
    use {
        'akinsho/toggleterm.nvim',
        config = function() require('plugins.toggleterm') end,
    }

    use {'nvim-telescope/telescope.nvim',
        config = function() require('plugins.telescope') end,
    }
    use 'nvim-telescope/telescope-ui-select.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        config = function() require('plugins.treesitter') end,
    }
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function() require('plugins.treesitter-context') end,
    }

    use {
        'williamboman/mason.nvim',
        config = function() require('plugins.mason') end,
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        after = 'mason.nvim',
        config = function() require('plugins.mason-lspconfig') end,
    }
    use {
        'neovim/nvim-lspconfig',
        after = 'mason-lspconfig.nvim',
        config = function() require('plugins.nvim-lspconfig') end,
    }
    -- use {
    --     'jose-elias-alvarez/null-ls.nvim',
    --     -- config = function() require('plugins.null-ls')
    -- }

    use {
        'folke/trouble.nvim',
        config = function() require('plugins.trouble') end,
    }

    use {
        'L3MON4D3/LuaSnip',
        config = function() require('plugins.luasnip') end,
    }
    -- use 'rafamadriz/friendly-snippets'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'
    use 'saadparwaiz1/cmp_luasnip'
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugins.nvim-cmp') end,
    }
    use 'onsails/lspkind.nvim'

    -- use {
    --     'dccsillag/magma-nvim',
    --     config = function() require('plugins.magma-nvim')
    -- }
end)
