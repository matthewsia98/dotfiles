return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- lazy = false,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- "mrjones2014/nvim-ts-rainbow",
            "HiPhish/rainbow-delimiters.nvim",
            -- "windwp/nvim-ts-autotag",
        },
        config = function()
            require("plugins.treesitter.config")
            require("plugins.treesitter.rainbow_delimiters")
        end,
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function()
            require("plugins.treesitter.context")
        end,
    },
    {
        "ckolkey/ts-node-action",
        config = function()
            require("plugins.treesitter.ts_node_action")
        end,
        keys = {
            {
                "<C-Space>",
                function()
                    require("ts-node-action").node_action()
                end,
                desc = "ts-node-action",
            },
        },
    },
}
