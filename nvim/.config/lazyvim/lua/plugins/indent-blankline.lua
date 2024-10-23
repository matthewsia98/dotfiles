return {
    "lukas-reineke/indent-blankline.nvim",
    opts = function(_, opts)
        opts.indent = {
            char = "▎",
            tab_char = "▎",
            highlight = {
                -- "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            },
        }

        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
    end,
}
