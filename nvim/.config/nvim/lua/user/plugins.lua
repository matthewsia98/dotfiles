local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

local lazy = require("lazy")
lazy.setup({
    "nvim-lua/plenary.nvim",

    -- COLORSCHEME
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("user.plugins.catppuccin")
        end,
    },

    -- START PAGE
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("user.plugins.dashboard-nvim")
        end,
    },

    -- SHOW KEYMAPS
    {
        "folke/which-key.nvim",
        lazy = false,
        config = function()
            require("user.plugins.which-key")
        end,
    },
    --
    -- -- SCROLLBAR
    -- -- {
    -- --     "petertriho/nvim-scrollbar",
    -- --     enabled = false,
    -- --     event = "BufReadPost",
    -- --     config = function()
    -- --         require("user.plugins.nvim-scrollbar")
    -- --     end,
    -- -- },
    --
    -- SMOOTH SCROLLING
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require("user.plugins.neoscroll")
        end,
    },
    --
    -- STATUS LINES
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
        dev = true,
        branch = "trouble-extension",
        config = function()
            require("user.plugins.lualine")
        end,
    },
    {
        dir = "~/.config/nvim/my-plugins/statusline.nvim",
        enabled = false,
        lazy = false,
        config = function()
            require("statusline")
        end,
    },

    -- FILE EXPLORER
    {
        "nvim-tree/nvim-tree.lua",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                config = function()
                    require("user.plugins.nvim-web-devicons")
                end,
            },
        },
        config = function()
            require("user.plugins.nvim-tree")
        end,
    },

    -- SEARCH
    {
        "kevinhwang91/nvim-hlslens",
        event = "CmdlineEnter",
        config = function()
            require("user.plugins.nvim-hlslens")
        end,
    },

    -- TERMINAL
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.toggleterm")
        end,
    },

    -- UI
    {
        "folke/noice.nvim",
        -- enabled = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                lazy = false,
                config = function()
                    require("user.plugins.nvim-notify")
                end,
            },
        },
        event = { "CmdlineEnter" },
        -- dev = false,
        config = function()
            require("user.plugins.noice")
        end,
    },

    -- PAIRS
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

    -- {
    --     "monaqa/dial.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("user.plugins.dial")
    --     end,
    -- },

    -- TOGGLE COMMENTS
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.Comment")
        end,
    },

    -- COLOR HIGHLIGHTER
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        config = function()
            require("user.plugins.nvim-colorizer")
        end,
    },

    -- INDENTATION GUIDES
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("user.plugins.indent-blankline")
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

    -- CODE FOLDING
    {
        "kevinhwang91/nvim-ufo",
        -- enabled = false,
        event = "BufReadPost",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        config = function()
            require("user.plugins.nvim-ufo")
        end,
    },

    -- TREESITTER
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
            {
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    require("user.plugins.treesitter-context")
                end,
            },
            {
                "nvim-treesitter/playground",
                cmd = "TSPlaygroundToggle",
            },
        },
        config = function()
            require("user.plugins.treesitter")
        end,
    },

    -- SNIPPETS
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("user.plugins.luasnip")
        end,
    },

    -- COMPLETION
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
            require("user.plugins.nvim-cmp")
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
        },
        event = "BufReadPre",
        config = function()
            require("user.plugins.neodev")
            require("user.plugins.lsp")
            require("user.plugins.lsp.mason")
            require("user.plugins.lsp.mason-lspconfig")
            require("user.plugins.lsp.nvim-lspconfig")
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.lsp.lspsaga")
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
        "zbirenbaum/copilot.lua",
        event = "VeryLazy",
        dependencies = {
            {
                "zbirenbaum/copilot-cmp",
                enabled = false,
                config = function()
                    require("user.plugins.copilot-cmp")
                end,
            },
        },
        config = function()
            require("user.plugins.copilot")
        end,
    },

    -- GIT
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
        enabled = false,
        config = function()
            require("user.plugins.git-messenger")
        end,
    },

    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        config = function()
            require("user.plugins.trouble")
        end,
    },

    -- FUZZY FINDER
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "debugloop/telescope-undo.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("user.plugins.telescope")
        end,
    },

    -- PYTHON INDENTATION
    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python",
        config = function()
            require("user.plugins.vim-python-pep8-indent")
        end,
    },

    -- Markdown Preview
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        ft = "markdown",
        config = function()
            require("user.plugins.peek")
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
    --
    -- {
    --     "dccsillag/magma-nvim",
    --     build = ":UpdateRemotePlugins",
    --     ft = "python",
    --     config = function()
    --         require("user.plugins.magma-nvim")
    --     end,
    -- },
}, {
    defaults = {
        lazy = true,
    },
    dev = {
        path = "~/repos",
    },
    install = {
        colorscheme = { "catppuccin" },
    },
    performance = {
        cache = {
            enabled = true,
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
    },
    ui = {
        border = "rounded",
    },
})
