local installed, mason_lspconfig = pcall(require, "mason-lspconfig")

if installed then
    mason_lspconfig.setup()
end
