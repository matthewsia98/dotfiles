local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git", lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

local lazy = require("lazy")
lazy.setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("user.plugins.catppuccin")
        end,
    },
    "nvim-lua/plenary.nvim",
    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("user.plugins.nvim-web-devicons")
        end,
    },
    {
        "glepnir/dashboard-nvim",
        lazy = false,
        config = function()
            require("user.plugins.dashboard-nvim")
        end,
    },
    {
        "folke/which-key.nvim",
        lazy = false,
        config = function()
            require("user.plugins.which-key")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.bufferline")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.lualine")
        end,
    },
    {
        "kyazdani42/nvim-tree.lua",
        event = "VeryLazy",
        config = function()
            require("user.plugins.nvim-tree")
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.toggleterm")
        end,
    },

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                config = function()
                    require("user.plugins.nvim-notify")
                end,
            }
        },
        event = { "CmdlineEnter", "RecordingEnter" },
        config = function()
            require("user.plugins.noice")
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("user.plugins.nvim-autopairs")
        end,
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("user.plugins.nvim-surround")
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.Comment")
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            require("user.plugins.nvim-colorizer")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("user.plugins.indent-blankline")
        end,
    },
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require("user.plugins.neoscroll")
        end,
    },

    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.leap")
        end,
    },

    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.mini")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    require("user.plugins.treesitter-context")
                end,
            },
        },
        config = function()
            require("user.plugins.treesitter")
        end,
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
    },

    {
        "zbirenbaum/copilot.lua",
        event = "VeryLazy",
        config = function()
            require("user.plugins.copilot")
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        -- event = "InsertEnter",
        config = function()
            require("user.plugins.lsp.luasnip")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",

            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",

            "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",

            "saadparwaiz1/cmp_luasnip",

            "onsails/lspkind.nvim",
        },
        config = function()
            require("user.plugins.lsp.nvim-cmp")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        event = "BufReadPre",
        config = function()
            require("user.plugins.lsp.mason")
            require("user.plugins.lsp.mason-lspconfig")
            require("user.plugins.lsp.nvim-lspconfig")
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        config = function()
            require("user.plugins.lsp.null-ls")
        end,

    },

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = function()
            require("user.plugins.gitsigns")
        end,
    },
    {
        "rhysd/git-messenger.vim",
        event = "BufReadPre",
        config = function()
            require("user.plugins.git-messenger")
        end,
    },

    {
        "folke/trouble.nvim",
        config = function()
            require("user.plugins.trouble")
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        event = "VeryLazy",
        config = function()
            require("user.plugins.telescope")
        end,
    },

    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python",
        config = function()
            require("user.plugins.vim-python-pep8-indent")
        end,
    },

    -- {
    --     "glacambre/firenvim",
    --     build = function() vim.fn["firenvim#install"](0) end,
    --     lazy = false,
    --     config = function()
    --         require("user.plugins.firenvim")
    --     end,
    -- },

    -- {
    --     "dccsillag/magma-nvim",
    --     build = ":UpdateRemotePlugins",
    --     ft = "python",
    --     config = function()
    --         require("user.plugins.magma-nvim")
    --     end,
    -- },
},
{
    defaults = {
        lazy = true
    },
    dev = {
        path = "~/repos",
    },
    install = {
        colorscheme = { "catppuccin" },
    },
    rtp = {
        disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
        },
    },
})
