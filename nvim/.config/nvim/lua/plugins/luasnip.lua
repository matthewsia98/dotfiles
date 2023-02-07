return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load({
            include = { "python", "lua", "java", "cpp", "c", "rust", "go", "shell" },
        })
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

        -- Deleting insert node default puts you back in Normal mode
        -- <C-G> changes to VISUAL, s clears and enters INSERT
        map("s", "<BS>", "<C-G>s")
    end,
}
