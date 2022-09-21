local installed, mason = pcall(require, 'mason')

if installed then
    mason.setup {
        ui = {
            icons = {
                package_installed = '✓',
                package_pending = '➜',
                package_uninstalled = '✗'
            },
        }
    }

    local exists = vim.fn.isdirectory(vim.fn.expand('~/.local/share/nvim/mason'))
    if exists == 0 then
        vim.cmd [[MasonInstall python-lsp-server black flake8 isort mypy]]
        vim.cmd [[MasonInstall lua-language-server luacheck stylua]]
        vim.cmd [[MasonInstall jdtls]]
    end
end
