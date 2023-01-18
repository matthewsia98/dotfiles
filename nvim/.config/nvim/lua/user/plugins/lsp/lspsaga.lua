local installed, saga = pcall(require, "lspsaga")

if installed then
    local catppuccin_installed, _ = pcall(require, "catppuccin.palettes")
    local colors = {}
    local kinds = {}
    if catppuccin_installed then
        colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors()
        kinds = require("catppuccin.groups.integrations.lsp_saga").custom_kind()
    end

    saga.setup({
        request_timeout = 5000,

        ui = {
            theme = "round",
            border = "rounded",
            colors = colors,
            kind = kinds,
        },

        lightbulb = {
            enable = false,
        },

        symbol_in_winbar = {
            enable = true,
            show_file = false,
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
    })

    -- Keymaps defined in nvim-lspconfig/init.lua
end
