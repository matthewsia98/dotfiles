require("lspconfig.ui.windows").default_options.border = "rounded"

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}
local handlers = {}

local on_attach = function(client, bufnr)
    require("plugins.lsp.keymaps").set_keymaps(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
        require("nvim-navbuddy").attach(client, bufnr)
    end
end

local config = require("config")
for _, lsp_name in ipairs(config.lsp.lsps_to_configure) do
    local server_config_file = string.format("%s/lua/plugins/lsp/servers/%s.lua", vim.fn.stdpath("config"), lsp_name)
    local file_exists = vim.fn.filereadable(server_config_file) ~= 0
    if not file_exists then
        require("plugins.lsp.utils").make_config_file(lsp_name)
    end
    require("plugins.lsp.servers." .. lsp_name).setup({
        capabilities = capabilities,
        flags = flags,
        handlers = handlers,
        on_attach = on_attach,
    })
end
