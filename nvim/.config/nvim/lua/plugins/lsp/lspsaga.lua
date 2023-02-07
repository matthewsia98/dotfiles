require("lspsaga").setup({
    request_timeout = 5000,

    ui = {
        theme = "round",
        border = "rounded",
        colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    },

    lightbulb = {
        enable = false,
    },

    symbol_in_winbar = {
        enable = true,
        show_file = true,
        folder_level = 99,
    },

    diagnostic = {
        twice_into = true,
    },

    finder = {
        edit = { "o", "<CR>" },
        vsplit = "v",
        split = "s",
        tabe = "t",
        quit = { "q", "<ESC>" },
    },

    definition = {
        edit = "<CR>",
        vsplit = "v",
        split = "s",
        tabe = "t",
        quit = "q",
        close = "<Esc>",
    },

    outline = {
        win_width = 30,
    },
})
