local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.set_config({
    history = true,
    enable_autosnippets = true,

    -- Fix extmarks not being cleared when deleting snippet (https://github.com/L3MON4D3/LuaSnip/issues/298) (https://github.com/L3MON4D3/LuaSnip/issues/116)
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
