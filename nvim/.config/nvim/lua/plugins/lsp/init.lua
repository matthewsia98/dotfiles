return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
        },
        event = "BufReadPre",
        config = function()
            require("plugins.lsp.config")
            require("plugins.lsp.neodev")
            require("plugins.lsp.mason")
            require("plugins.lsp.mason_lspconfig")
            require("plugins.lsp.nvim_lspconfig")
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        config = function()
            require("plugins.lsp.null_ls")
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        cmd = "Lspsaga",
        -- event = "BufReadPre",
        config = function()
            require("plugins.lsp.lspsaga")
        end,
    },
    {
        "SmiteshP/nvim-navic",
        config = function()
            require("plugins.lsp.navic")
        end,
    },
}
