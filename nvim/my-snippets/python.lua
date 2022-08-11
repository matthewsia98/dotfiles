local ls = require('luasnip')
local e = require('luasnip.extras')
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
local fmt = require('luasnip.extras.fmt').fmt


return {
    s('clsinit',
        fmt([[
            class {}{}:
                """
                {}
                """
                def __init__(self, {}):
                    {}
                    {}
            ]],
            {
                i(1, 'ClassName'),
                c(2, {
                    t(''),
                    sn(nil, {
                        t('('),
                        i(1, 'BaseClass'),
                        t(')')
                    })
                }),
                dl(3, 'Docstring for ' .. l._1, 1),
                i(4, 'args'),
                d(5, function(args)
                    local splits = vim.split(args[1][1], ', ')
                    local texts = {}
                    for idx, split in ipairs(splits) do
                        split = split:match('([%w_]*)=?')
                        local curr = ''
                        if idx == 1 then
                            curr = 'self.' .. split .. ' = ' .. split
                        else
                            curr = '\tself.' .. split .. ' = ' .. split
                        end
                        table.insert(texts, curr)
                    end
                    return sn(nil,
                        t(texts)
                    )
                end, {4}),
                i(0)
            }
        )
    ),
    s('init',
        fmt([[
            def __init__(self, {}):
                {}
                {}
            ]],
            {
                i(1, 'args'),
                d(2, function(args)
                    local splits = vim.split(args[1][1], ', ')
                    local texts = {}
                    for idx, split in ipairs(splits) do
                        split = split:match('([%w_]*)=?')
                        local curr = ''
                        if idx == 1 then
                            curr = 'self.' .. split .. ' = ' .. split
                        else
                            curr = '\tself.' .. split .. ' = ' .. split
                        end
                        table.insert(texts, curr)
                    end
                    return sn(nil,
                        t(texts)
                    )
                end, {1}),
                i(0)
            }
        )
    ),
    s('pytorch_train',
        fmt([[
            for epoch in range({}):
                for batch_num, (batch_Xs, batch_ys) in enumerate({}):
                    {}.zero_grad()

                    {}

                    {} = {}({}, {})
                    {}.backward()
                    {}.step()

                    {}
            ]],
            {
                i(1, 'N'),
                d(2, function()
                    local imported_tqdm = false
                    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                    for _, line in ipairs(lines) do
                        if string.match(line, 'import tqdm') then
                            imported_tqdm = true
                            break
                        end
                    end
                    if imported_tqdm then
                        return sn(nil, {
                            t('tqdm('),
                            i(1, 'dataloader'),
                            t(')')
                        })
                    else
                        return sn(nil, {
                            i(1, 'dataloader')
                        })
                    end
                end),
                i(3, 'optimizer'),
                i(4),
                i(5, 'loss'),
                i(6,'loss_function'),
                i(7, 'outputs'),
                i(8, 'batch_ys'),
                f(function(args)
                    return args[1][1]
                end, {5}),
                f(function(args)
                    return args[1][1]
                end, {3}),
                i(0)
            }
        )
    ),
}
