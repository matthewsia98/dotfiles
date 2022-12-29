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

return {
    s(
        "ipairs",
        fmt(
            [[
            for {}, {} in ipairs({}) do
                {}
            end
            ]],
            {
                i(1, "_"),
                i(2, "item"),
                i(3, "table"),
                i(4, "-- For loop body"),
            }
        )
    ),
    s(
        "pairs",
        fmt(
            [[
            for {}, {} in pairs({}) do
                {}
            end
            ]],
            {
                i(1, "key"),
                i(2, "value"),
                i(3, "table"),
                i(4, "-- For loop body"),
            }
        )
    ),
    s(
        "function",
        fmt(
            [[
            {}function{}({})
                {}
            end
            ]],
            {
                c(1, {
                    t("local "),
                    t(""),
                }),
                c(2, {
                    sn(nil, {
                        t(" "),
                        i(1, "function_name"),
                    }),
                    t(""),
                }),
                c(3, {
                    sn(nil, {
                        i(1, "args"),
                    }),
                    t(""),
                }),
                i(4, "-- Function body"),
            }
        )
    ),
}, {
    s(
        "ptbl",
        fmt(
            [[
            for {}, {} in {}({}) do
                {}
            end
            ]],
            {
                i(1, "k"),
                i(2, "v"),
                c(3, {
                    t("pairs"),
                    t("ipairs"),
                }),
                i(4, "table_name"),
                d(5, function(args)
                    local key = args[1][1]
                    local value = args[2][1]

                    if key == "_" then
                        return sn(nil, {
                            t("print("),
                            t(value),
                            t(")"),
                        })
                    else
                        return sn(nil, {
                            t("print("),
                            t(string.format("tostring(%s)", key)),
                            t(" .. ' = ' .. "),
                            t(string.format("tostring(%s)", value)),
                            t(")"),
                        })
                    end
                end, { 1, 2 }),
            }
        )
    ),
}
