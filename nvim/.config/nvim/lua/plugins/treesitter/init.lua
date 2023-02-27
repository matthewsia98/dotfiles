return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
        },
        config = function()
            require("plugins.treesitter.config")
        end,
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "CursorMoved",
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