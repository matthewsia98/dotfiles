local npairs = require('nvim-autopairs')
npairs.setup {
    check_ts = true,
}

local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
)
