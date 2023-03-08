local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.set_config({
    -- Enable jumping back to previous snippets
    history = false,
    enable_autosnippets = true,

    --[[
    REFERENCE: (https://github.com/L3MON4D3/LuaSnip/issues/298) (https://github.com/L3MON4D3/LuaSnip/issues/116)
    Fix extmarks not being cleared when deleting snippet
    ]]
    region_check_events = "CursorMoved,InsertEnter",
    delete_check_events = "TextChanged,InsertLeave",

    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { " ﬋ Current Choice ", "Search" } },
                priority = 1,
            },
        },
    },
})

require("luasnip.loaders.from_lua").lazy_load({
    paths = "~/.config/nvim/my-snippets",
})
