return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
            "p00f/nvim-ts-rainbow",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = {
                    -- Required for noice lsp overrides
                    "vim",
                    "regex",
                    "lua",
                    "bash",
                    "markdown",
                    "markdown_inline",

                    "help",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enabled = false },
                rainbow = { enable = true },
                playground = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        include_surrounding_whitespace = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = { ["]]"] = "@parameter.inner" },
                        swap_previous = { ["[["] = "@parameter.inner" },
                    },
                    move = {
                        enable = true,
                        set_jumps = false,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                        },
                        goto_next_end = {},
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                        },
                        goto_previous_end = {},
                        goto_next = {},
                        goto_previous = {},
                    },
                },
            })

            require("treesitter-context").setup({
                enable = true,
                patterns = {
                    lua = {
                        "table_constructor",
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
    },
}
