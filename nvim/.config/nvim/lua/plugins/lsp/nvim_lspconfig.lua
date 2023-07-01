local M = {}

require("lspconfig.ui.windows").default_options.border = "rounded"

local capabilities =
    vim.tbl_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())

local flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}

local handlers = {}

local group = vim.api.nvim_create_augroup("LspOnAttach", { clear = true })
M.on_attach = function(client, bufnr)
    require("plugins.lsp.keymaps").set_keymaps(client, bufnr)

    -- Enable inlay hints only in insert mode
    -- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    --     group = group,
    --     buffer = bufnr,
    --     callback = function()
    --         vim.lsp.buf.inlay_hint(0, true)
    --     end,
    -- })
    -- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    --     group = group,
    --     buffer = bufnr,
    --     callback = function()
    --         vim.lsp.buf.inlay_hint(0, false)
    --     end,
    -- })
    vim.api.nvim_buf_create_user_command(bufnr, "LspInlayHintToggle", function()
        vim.lsp.inlay_hint(bufnr)
    end, {})

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
        require("nvim-navbuddy").attach(client, bufnr)
    end
    -- if client.supports_method("textDocument/inlayHint") then
    --     require("lsp-inlayhints").on_attach(client, bufnr)
    -- end

    -- REFERENCE: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --     buffer = bufnr,
    --     callback = function()
    --         local opts = {
    --             focusable = true,
    --             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --             border = "rounded",
    --             source = "always",
    --             prefix = " ",
    --             scope = "cursor",
    --         }
    --         vim.diagnostic.open_float(nil, opts)
    --     end,
    -- })
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
        on_attach = M.on_attach,
    })
end

return M
