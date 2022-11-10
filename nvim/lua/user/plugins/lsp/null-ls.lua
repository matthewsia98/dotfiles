local installed, null_ls = pcall(require, 'null-ls')

if installed then
    null_ls.setup({
        sources = {
            -- PYTHON --
            null_ls.builtins.diagnostics.flake8.with({
                -- extra_args = {
                --     '--config', vim.fn.expand('~/.config/nvim/.flake8')
                -- }
            }),
            null_ls.builtins.diagnostics.mypy.with({
                -- extra_args = {
                --     '--config', vim.fn.expand('~/.config/nvim/.mypy.ini')
                -- }
            }),
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,

            -- LUA --
            null_ls.builtins.diagnostics.luacheck.with({
                -- extra_args = {
                --     '--config', vim.fn.expand('~/.config/nvim/.luacheckrc')
                -- },
            }),
            null_ls.builtins.formatting.stylua,
        },
    })
end
