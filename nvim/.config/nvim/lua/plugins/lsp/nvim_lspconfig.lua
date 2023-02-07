require("lspconfig.ui.windows").default_options.border = "rounded"

local cmp_installed, cmp = pcall(require, "cmp_nvim_lsp")
local capabilities = cmp_installed and cmp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

local flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}
local handlers = {}
local on_attach = function(client, bufnr)
    require("plugins.lsp.keymaps").set_keymaps(client, bufnr)
end

local config = require("config")
for _, lsp_name in ipairs(config.lsp.lsps_to_configure) do
    local server_config_file = vim.fn.expand("~/.config/nvim/lua/plugins/lsp/servers/" .. lsp_name .. ".lua")
    local file_exists = vim.fn.filereadable(server_config_file) ~= 0
    if file_exists then
        require("plugins.lsp.servers." .. lsp_name).setup({
            capabilities = capabilities,
            flags = flags,
            handlers = handlers,
            on_attach = on_attach,
        })
    else
        require("plugins.lsp.utils").make_config_file(lsp_name)
    end
end
