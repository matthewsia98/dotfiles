local installed, neodev = pcall(require, "neodev")

if installed then
    neodev.setup({
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
end
