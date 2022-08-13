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


local ext_opts = {
    -- these ext_opts are applied when the node is active (e.g. it has been
    -- jumped into, and not out yet).
    active = 
    -- this is the table actually passed to `nvim_buf_set_extmark`.
    {
        -- highlight the text inside the node red.
        hl_group = "DiagnosticVirtualTextError"
    },
    -- these ext_opts are applied when the node is not active, but
    -- the snippet still is.
    passive = {
        -- add virtual text on the line of the node, behind all text.
        virt_text = {{"virtual text!!", "GruvboxBlue"}}
    },
    -- and these are applied when both the node and the snippet are inactive.
    snippet_passive = {}
}


return {
    s('timenow',
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
    s('datetimenow',
        f(function()
            return os.date('%A %B %d, %Y\t%H:%M:%S')
        end
        )
    ),
    s("trig", {
        i(1, "text1", {
            node_ext_opts = ext_opts
        }),
        i(2, "text2", {
            node_ext_opts = ext_opts
        })
    })
}
