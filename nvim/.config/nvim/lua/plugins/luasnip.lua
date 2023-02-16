return {
    "L3MON4D3/LuaSnip",
    -- dependencies = {
    --     "rafamadriz/friendly-snippets",
    -- },
    config = function()
        local luasnip = require("luasnip")
        local types = require("luasnip.util.types")

        luasnip.config.set_config({
            history = true,
            enable_autosnippets = true,
            -- Fix extmarks not being cleared when deleting snippet (https://github.com/L3MON4D3/LuaSnip/issues/298)
            delete_check_events = "TextChanged",
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { " ﬋ Current Choice ", "Search" } },
                        priority = 1,
                    },
                },
            },
        })

        -- require("luasnip.loaders.from_vscode").lazy_load({
        --     include = { "python", "lua", "java", "cpp", "c", "rust", "go", "shell" },
        -- })
        require("luasnip.loaders.from_lua").lazy_load({
            paths = "~/.config/nvim/my-snippets",
        })

        local map = require("keymaps").map

        map({ "i", "s" }, "<C-l>", function()
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            end
        end, { desc = "Luasnip jump to next" })
        map({ "i", "s" }, "<C-h>", function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { desc = "Luasnip jump to previous" })

        map({ "i", "s" }, "<C-n>", function()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { desc = "Luasnip next choice" })
        map({ "i", "s" }, "<C-p>", function()
            if luasnip.choice_active() then
                luasnip.change_choice(-1)
            end
        end, { desc = "Luasnip previous choice" })

        map({ "i", "s" }, "<C-u>", function()
            require("luasnip.extras.select_choice")()
        end, { desc = "Luasnip select choice" })
    end,
}
