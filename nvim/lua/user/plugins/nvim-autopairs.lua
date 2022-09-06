local installed, npairs = pcall(require, 'nvim-autopairs')

if installed then
    npairs.setup {
        check_ts = true,
    }

    local cmp = require('cmp')
    cmp.event:on(
        'confirm_done',
        require('nvim-autopairs.completion.cmp').on_confirm_done()
    )
end
