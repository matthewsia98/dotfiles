local installed, null_ls = pcall(require, "null-ls")

if installed then
    null_ls.setup({
        sources = {
            -- PYTHON --
            null_ls.builtins.diagnostics.flake8,
            null_ls.builtins.diagnostics.mypy,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,

            -- LUA --
            null_ls.builtins.diagnostics.luacheck,
            null_ls.builtins.formatting.stylua,

            -- SHELL --
            null_ls.builtins.diagnostics.shellcheck.with({
                extra_args = { "--shell", "bash" },
            }),
        },
    })
end
