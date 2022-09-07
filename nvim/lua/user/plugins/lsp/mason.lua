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
end
