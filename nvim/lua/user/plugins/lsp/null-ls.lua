local installed, null_ls = pcall(require, 'null-ls')

if installed then
    null_ls.setup {
        sources =  {
            -- PYTHON --
            null_ls.builtins.diagnostics.flake8,
            null_ls.builtins.diagnostics.mypy,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,

            -- LUA --
            null_ls.builtins.diagnostics.luacheck.with({
                extra_args = {
                    '--globals', 'vim', 'P', 'R', 'catppuccin_palette',
                    '--std', 'luajit'
                },
            }),
            null_ls.builtins.formatting.stylua,
        },
        on_attach = function(client, bufnr)
            local root_dir = client['config']['root_dir']
            local filepath = vim.fn.expand("%")

            local msg = { 'Language Server: ' .. client['name'] }
            if root_dir then
                table.insert(msg, 'Root Directory: ' .. client['config']['root_dir'])
            else
                table.insert(msg, 'Root Directory: ' .. filepath .. ' (Single file mode)')
            end

            local notify_installed, notify = pcall(require, 'notify')
            if notify_installed then
                notify(msg, 'info', {
                    title = ' LSP',
                    timeout = 1000,
                })
            end
        end,
    }
end
