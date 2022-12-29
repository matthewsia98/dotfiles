local installed, luasnip = pcall(require, "luasnip")

if installed then
    local types = require("luasnip.util.types")

    luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    virt_text = { { " ﬋ Current Choice ", "Search" } },
                },
            },
        },
        region_check_events = "InsertEnter",
        delete_check_events = "TextChanged,InsertLeave",
    })

    require('luasnip.loaders.from_vscode').lazy_load({
        include = { "python", "lua", },
        -- exclude = { "python", },
    })
    require("luasnip.loaders.from_lua").lazy_load({
        paths = "~/.config/nvim/my-snippets",
    })

    local keys = require("user.keymaps")

    keys.map({ "i", "s" }, "<C-l>", function()
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        end
    end)
    keys.map({ "i", "s" }, "<C-h>", function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end)

    keys.map({ "i", "s" }, "<C-n>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end)
    keys.map({ "i", "s" }, "<C-p>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(-1)
        end
    end)

    -- Deleting insert node default puts you back in Normal mode
    -- <C-G> changes to VISUAL, s clears and enters INSERT
    keys.map("s", "<BS>", "<C-G>s")
end