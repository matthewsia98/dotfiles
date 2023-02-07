local mason = require("mason")

mason.setup({
    PATH = "prepend",
    ui = {
        check_outdated_packages_on_open = true,
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

local config = require("config")

local show_ui = true
local registry = require("mason-registry")
for _, package_name in ipairs(config.lsp.mason_packages_to_install) do
    local package = registry.get_package(package_name)
    if not package:is_installed() then
        if show_ui then
            vim.cmd([[Mason]])
            show_ui = false
        end
        package:install()
    end
end

local pylsp = registry.get_package("python-lsp-server")
pylsp:on("install:success", function()
    vim.schedule(function()
        local plugins = config.lsp.pylsp_plugins_to_install
        local install_cmd = {
            vim.fn.expand("~/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/python"),
            "-m",
            "pip",
            "install",
        }
        for _, plugin in ipairs(plugins) do
            table.insert(install_cmd, plugin)
        end
        vim.fn.system(install_cmd)
        vim.notify("python-lsp-server plugins installed", "info", { title = "mason.nvim" })
    end)
end)
