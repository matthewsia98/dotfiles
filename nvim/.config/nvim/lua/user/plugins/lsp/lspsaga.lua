local installed, saga = pcall(require, "lspsaga")

if installed then
    saga.init_lsp_saga({
        custom_kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        border_style = "rounded",
        code_action_lightbulb = {
            enable = false
        },
        finder_action_keys = {
            open = { "<CR>" },
            vsplit = "v",
            split = "s",
            tabe = "t",
            quit = { "q", "<Esc>" },
        },
        definition_action_keys = {
            vsplit = "v",
            split = "s",
            tabe = "t",
            quit = "q",
        },
    })

    local keys = require("user.keymaps")

    keys.map("n", "<leader>lf", function()
        require("lspsaga.finder"):lsp_finder()
    end, { desc = "Lsp Finder (Lspsaga)" })

    keys.map("n", "<leader>ld", function()
        require("lspsaga.definition"):peek_definition()
    end, { desc = "Peek Definition (Lspsaga)" })
end
