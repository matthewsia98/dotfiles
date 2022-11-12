local installed, comment = pcall(require, 'Comment')

if installed then
    local ft = require('Comment.ft')
    ft({ 'python', 'zsh' }, { '#%s', '#%s' })

    comment.setup {
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
            line = 'gcc',
            block = 'gbc',
        },
        opleader = {
            line = 'gc',
            block = 'gb',
        },
        extra = {
            above = 'gcO',
            below = 'gco',
            eol = 'gcA',
        },
    }
end
