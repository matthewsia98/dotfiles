require("neodev").setup({
    library = {
        enabled = true,
        runtime = true,
        types = true,
        plugins = true,
    },
    setup_jsonls = false,
    override = function(root_dir, options) end,
    lspconfig = true,
})
