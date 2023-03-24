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

local auto_snippets = {
    s(
        { trig = "strf" },
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
}

local snippets = {
    s(
        {
            trig = "if",
            snippetType = "autosnippet",
            condition = function(line_to_cursor, matched_trigger, captures)
                local _, row, col, _, _ = unpack(vim.fn.getcurpos())
                local node = vim.treesitter.get_node({
                    pos = { row - 1, col - #matched_trigger - 1 },
                })
                return node and node:type() ~= "comment"
            end,
        },
        fmt(
            [[
            if {} then
                {}
            end
            ]],
            {
                i(1, "condition"),
                i(2, "body"),
            }
        )
    ),

    s(
        { trig = "function" },
        fmt(
            [[
            {}function {}({})
                {}
            end
            ]],
            {
                c(1, {
                    t("local "),
                    t(""),
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
}

return snippets, auto_snippets

-- return {
--     s(
--         "ipairs",
--         fmt(
--             [[
--             for {}, {} in ipairs({}) do
--                 {}
--             end
--             ]],
--             {
--                 i(1, "_"),
--                 i(2, "item"),
--                 i(3, "table"),
--                 i(4, "-- For loop body"),
--             }
--         )
--     ),
--     s(
--         "pairs",
--         fmt(
--             [[
--             for {}, {} in pairs({}) do
--                 {}
--             end
--             ]],
--             {
--                 i(1, "key"),
--                 i(2, "value"),
--                 i(3, "table"),
--                 i(4, "-- For loop body"),
--             }
--         )
--     ),
--     s(
--         "function",
--         fmt(
--             [[
--             {}function{}({})
--                 {}
--             end
--             ]],
--             {
--                 c(1, {
--                     t("local "),
--                     t(""),
--                 }),
--                 c(2, {
--                     sn(nil, {
--                         t(" "),
--                         i(1, "function_name"),
--                     }),
--                     t(""),
--                 }),
--                 c(3, {
--                     sn(nil, {
--                         i(1, "args"),
--                     }),
--                     t(""),
--                 }),
--                 i(4, "-- Function body"),
--             }
--         )
--     ),
-- }, {
--     s(
--         "ptbl",
--         fmt(
--             [[
--             for {}, {} in {}({}) do
--                 {}
--             end
--             ]],
--             {
--                 i(1, "k"),
--                 i(2, "v"),
--                 c(3, {
--                     t("pairs"),
--                     t("ipairs"),
--                 }),
--                 i(4, "table_name"),
--                 d(5, function(args)
--                     local key = args[1][1]
--                     local value = args[2][1]
--
--                     if key == "_" then
--                         return sn(nil, {
--                             t("print("),
--                             t(value),
--                             t(")"),
--                         })
--                     else
--                         return sn(nil, {
--                             t("print("),
--                             t(string.format("tostring(%s)", key)),
--                             t(" .. ' = ' .. "),
--                             t(string.format("tostring(%s)", value)),
--                             t(")"),
--                         })
--                     end
--                 end, { 1, 2 }),
--             }
--         )
--     ),
-- }
