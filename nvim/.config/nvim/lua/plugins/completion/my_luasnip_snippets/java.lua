local ls = require("luasnip")
local e = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local l = e.lambda
local dl = e.dynamic_lambda
local sn = ls.sn
local rep = e.rep

return {}, {
    s(
        "sout",
        fmt(
            [[
            System.out.println({});{}
            ]],
            {
                i(1, ""),
                i(0),
            }
        )
    ),
    s(
        "psvm",
        fmt(
            [[
            public static void main(String[] args) {{
                {}
            }}
            ]],
            {
                i(1, ""),
            }
        )
    ),
}
