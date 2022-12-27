local installed, mason = pcall(require, "mason")

if installed then
    mason.setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })

    local packages = {
        "python-lsp-server",
        "flake8",
        "mypy",
        "black",
        "isort",

        "lua-language-server",
        "luacheck",
        "stylua",
    }
    local registry = require("mason-registry")
    for _, package_name in ipairs(packages) do
        local package = registry.get_package(package_name)
        if not package:is_installed() then
            package:install()
        end
    end
end
