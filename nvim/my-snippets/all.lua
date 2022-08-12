local ls = require('luasnip')
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.sn
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

return {
    s('now',
        f(function()
            return os.date('%H:%M:%S')
        end
        )
    ),
    s('today',
        f(function()
            return os.date('%A %B %d, %Y')
        end
        )
    ),
}
