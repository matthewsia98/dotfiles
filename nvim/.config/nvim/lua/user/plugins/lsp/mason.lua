local installed, mason = pcall(require, "mason")

if installed then
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

    local config = require("user.config")
    local packages = config.mason_packages_to_install

    local show_ui = true
    local registry = require("mason-registry")
    for _, package_name in ipairs(packages) do
        local package = registry.get_package(package_name)
        if not package:is_installed() then
            if show_ui then
                vim.cmd([[Mason]])
                show_ui = false
            end

            if package_name == "python-lsp-server" then
                package:install():once("closed", function()
                    if not package:is_installed() then
                        -- installation failed
                        vim.notify("python-lsp-server installation failed", "info", { title = "mason.nvim" })
                        return
                    end

                    vim.schedule(function()
                        local plugins = require("user.config").pylsp_plugins_to_install
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
            else
                package:install()
            end
        end
    end
end
