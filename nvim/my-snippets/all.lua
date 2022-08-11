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
            return os.date('%A %B %d %Y %H:%M:%S')
        end
        )
    ),
    s('test',
        fmt([[
            Argument 1: {}
            This is Argument 1 repeated: {}
            Choice Node: {}
            ]],
            {
                i(1),
                d(2, function(args)
                    return sn(nil, t(args[1][1]))
                end, {1}
                ),
                c(3, {t('First Choice'), t('Second Choice')})
            }
        )
    )
}
