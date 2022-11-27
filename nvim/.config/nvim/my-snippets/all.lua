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
        "timenow",
        f(function()
            return os.date("%H:%M:%S")
        end)
    ),
    s(
        "today",
        f(function()
            return os.date("%A %B %d, %Y")
        end)
    ),
    s(
        "datetimenow",
        f(function()
            return os.date("%A, %B %d %Y, %H:%M:%S")
        end)
    ),
}