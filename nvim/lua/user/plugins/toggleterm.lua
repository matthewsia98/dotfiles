local installed, toggleterm = pcall(require, 'toggleterm')
local keys = require('user.keymaps')

if installed then
    toggleterm.setup {
        size = 40,
        direction = 'vertical',
        shell = '/bin/zsh',
    }

    keys.map('n', '<leader>tt', '<cmd>ToggleTerm<CR>')
    keys.map('n', '<leader>tr',
        function()
            local winwidth = vim.fn.winwidth(0)
            local filetype = vim.bo.filetype
            local filepath = vim.fn.expand('%')
            local command
            if filetype == 'lua' then
                command = 'lua ' .. filepath
            elseif filetype == 'python' then
                command = 'python ' .. filepath
            elseif filetype == 'java' then
                command = 'javac ' .. filepath .. '; java ' .. filepath:gsub('.java', '')
            end
            vim.cmd('TermExec size=' .. math.floor(winwidth / 3) .. ' cmd="' .. command .. '"')
        end
    )
end
