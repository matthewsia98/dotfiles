return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            -- "hrsh7th/cmp-nvim-lsp-signature-help", -- handled by noice
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
        event = "InsertEnter",
        config = function()
            require("plugins.completion.cmp")
            require("plugins.completion.keymaps").set_keymaps()
        end,
    },
    {
        "hrsh7th/cmp-cmdline",
        enabled = false,
        dependencies = {
            "dmitmel/cmp-cmdline-history",
        },
        event = "CmdlineEnter",
        config = function()
            require("cmp").setup.cmdline(":", {
                sources = {
                    { name = "cmdline", max_item_count = 10 },
                    { name = "cmdline_history", max_item_count = 5 },
                    { name = "nvim_lsp", max_item_count = 10 },
                    { name = "path", max_item_count = 5 },
                },
            })
            require("cmp").setup.cmdline({ "/", "?" }, {
                sources = {
                    { name = "buffer", max_item_count = 10 },
                },
            })
        end,
        keys = {
            { ":" },
            { "/" },
            { "?" },
        },
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
