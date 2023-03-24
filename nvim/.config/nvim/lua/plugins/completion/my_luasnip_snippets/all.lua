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

local autosnippets = {}

local snippets = {
    s(
        { trig = "timenow" },
        f(function()
            return os.date("%H:%M:%S")
        end)
    ),
    s(
        { trig = "today" },
        f(function()
            return os.date("%A %B %d, %Y")
        end)
    ),
    s(
        { trig = "datetimenow" },
        f(function()
            return os.date("%A, %B %d %Y, %H:%M:%S")
        end)
    ),
    s({ trig = "week" }, {
        f(function()
            local monday = os.capture([[date -d "monday" +"%A, %B %d"]])
            return monday
        end),
        i(1),
        t(" - "),
        c(2, {
            sn(nil, {
                f(function()
                    local friday = os.capture([[date -d "monday + 4days" +"%A, %B %d"]])
                    return friday
                end),
                i(1),
            }),
            sn(nil, {
                f(function()
                    local sunday = os.capture([[date -d "monday + 6days" +"%A, %B %d"]])
                    return sunday
                end),
                i(1),
            }),
        }),
    }),
    s({ trig = "pweek" }, {
        f(function()
            local monday = os.capture([[date -d "last-monday" +"%A, %B %d"]])
            return monday
        end),
        i(1),
        t(" - "),
        c(2, {
            sn(nil, {

                f(function()
                    local friday = os.capture([[date -d "last-monday + 4days" +"%A, %B %d"]])
                    return friday
                end),
                i(1),
            }),
            sn(nil, {
                f(function()
                    local sunday = os.capture([[date -d "last-monday + 6days" +"%A, %B %d"]])
                    return sunday
                end),
                i(1),
            }),
        }),
    }),
}

return snippets, autosnippets
