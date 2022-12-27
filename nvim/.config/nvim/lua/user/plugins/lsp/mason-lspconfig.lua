local installed, mason_lspconfig = pcall(require, "mason-lspconfig")

if installed then
    mason_lspconfig.setup({
        ensure_installed = {},
        automatic_installation = false,
    })
end
