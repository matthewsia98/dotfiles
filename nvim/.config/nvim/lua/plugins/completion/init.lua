return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            -- "dmitmel/cmp-cmdline-history",
            "onsails/lspkind.nvim",
        },
        -- event = { "InsertEnter", "CmdlineEnter" },
        event = "InsertEnter",
        config = function()
            require("plugins.completion.cmp")
            require("plugins.completion.keymaps").set_keymaps()
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            enabled = false,
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load({
                    include = { "python", "lua", "java", "cpp", "c", "rust", "go", "shell" },
                })
            end,
        },
        config = function()
            require("plugins.completion.luasnip")
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("plugins.completion.copilot")
        end,
    },
}
