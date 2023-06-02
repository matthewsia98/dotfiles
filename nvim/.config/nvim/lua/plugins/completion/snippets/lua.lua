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

local utils = require("plugins.completion.snippets.utils")

return {
    s(
        {
            trig = "strf",
            snippetType = "autosnippet",
        },
        fmt(
            [[
            string.format("{}", {})
            ]],
            {
                i(1, "format"),
                i(2, "args"),
            }
        )
    ),
    s(
        {
            trig = "if ",
            -- snippetType = "autosnippet",
            condition = utils.expand_node,
        },
        fmt(
            [[
            if {} then
                {}{}
            end
            ]],
            {
                i(1, "true"),
                i(2, "-- if body"),
                c(3, {
                    t(""),
                    sn(nil, {
                        t({ "", "elseif " }),
                        i(1, "true"),
                        t({ " then", "\t" }),
                        i(2, "-- elseif body"),
                        -- t({ "", "else", "\t" }),
                        -- i(3, "-- else body"),
                    }),
                    sn(nil, {
                        t({ "", "else", "\t" }),
                        i(1, "-- else body"),
                    }),
                }),
            }
        )
    ),
    s(
        {
            trig = "function[%s(]",
            regTrig = true,
            -- snippetType = "autosnippet",
            condition = utils.expand_node,
        },
        fmt(
            [[
            {}function {}({})
                {}
            end
            ]],
            {
                c(1, {
                    t(""),
                    t("local "),
                }),
                i(2, "function_name"),
                c(3, {
                    i(1, "args"),
                    t("..."),
                    t(""),
                }),
                i(4, "-- Function body"),
            }
        )
    ),
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
}
