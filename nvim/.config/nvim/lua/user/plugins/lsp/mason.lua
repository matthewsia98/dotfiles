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

    local exists = vim.fn.isdirectory(vim.fn.expand("~/.local/share/nvim/mason"))
    if exists == 0 then
        local languages = vim.g.mason_languages_to_install
        if vim.tbl_contains(languages, "python") then
            vim.cmd([[MasonInstall python-lsp-server black flake8 isort mypy]])
        end

        if vim.tbl_contains(languages, "lua") then
            vim.cmd([[MasonInstall lua-language-server luacheck stylua]])
        end

        if vim.tbl_contains(languages, "java") then
            vim.cmd([[MasonInstall jdtls]])
        end
    end
end
