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

    indent = {
        enable = true,
        disable = { "python" },
    },

    rainbow = {
        enable = true,
        query = { "rainbow-parens" },
        strategy = require("ts-rainbow.strategy.global"),
    },

    playground = { enable = true },

    textobjects = {
        select = {
            enable = true,
            include_surrounding_whitespace = false,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "a function" },
                ["if"] = { query = "@function.inner", desc = "inner function" },
                ["aa"] = { query = "@parameter.outer", desc = "a parameter" },
                ["ia"] = { query = "@parameter.inner", desc = "inner parameter" },
                ["ac"] = { query = "@call.outer", desc = "a call" },
                ["ic"] = { query = "@call.inner", desc = "inner call" },
                ["ah"] = { query = "@assignment.lhs", desc = "assignment left side" },
                ["al"] = { query = "@assignment.rhs", desc = "assignment right side" },
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["]]"] = { query = "@parameter.inner", desc = "Swap next parameter" },
            },
            swap_previous = {
                ["[["] = { query = "@parameter.inner", desc = "Swap previous parameter" },
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "Next Function Start" },
                ["]c"] = { query = "@comment.outer", desc = "Next Comment Start" },
            },
            goto_next_end = {},
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "Previous Function Start" },
                ["[c"] = { query = "@comment.outer", desc = "Previous Comment Start" },
            },
            goto_previous_end = {},
            goto_next = {},
            goto_previous = {},
        },
    },
})
