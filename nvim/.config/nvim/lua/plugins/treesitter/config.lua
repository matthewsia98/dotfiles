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
    indent = { enable = true, disable = { "python" } },
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
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@call.outer",
                ["ic"] = "@call.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
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
