local notify_installed, notify = pcall(require, 'notify')

-- SIGNS --
vim.fn.sign_define(
    'DiagnosticSignError',
    { texthl = 'DiagnosticSignError', text = ' ', numhl = 'DiagnosticSignError' }
)

vim.fn.sign_define(
    'DiagnosticSignWarn',
    { texthl = 'DiagnosticSignWarn', text = ' ', numhl = 'DiagnosticSignWarn' }
)

vim.fn.sign_define(
    'DiagnosticSignHint',
    { texthl = 'DiagnosticSignHint', text = ' ', numhl = 'DiagnosticSignHint' }
)

vim.fn.sign_define(
    'DiagnosticSignInfo',
    { texthl = 'DiagnosticSignInfo', text = ' ', numhl = 'DiagnosticSignInfo' }
)

-- Show only one sign in sign column
-- -- Create a custom namespace. This will aggregate signs from all other
-- -- namespaces and only show the one with the highest severity on a
-- -- given line
-- local ns = vim.api.nvim_create_namespace("my_namespace")
--
-- -- Get a reference to the original signs handler
-- local orig_signs_handler = vim.diagnostic.handlers.signs
--
-- -- Override the built-in signs handler
-- vim.diagnostic.handlers.signs = {
--     show = function(_, bufnr, _, opts)
--         -- Get all diagnostics from the whole buffer rather than just the
--         -- diagnostics passed to the handler
--         local diagnostics = vim.diagnostic.get(bufnr)
--
--         -- Find the "worst" diagnostic per line
--         local max_severity_per_line = {}
--         for _, d in pairs(diagnostics) do
--             local m = max_severity_per_line[d.lnum]
--             if not m or d.severity < m.severity then
--                 max_severity_per_line[d.lnum] = d
--             end
--         end
--
--         -- Pass the filtered diagnostics (with our custom namespace) to
--         -- the original handler
--         local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
--         orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
--     end,
--     hide = function(_, bufnr)
--         orig_signs_handler.hide(ns, bufnr)
--     end,
-- }


vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = true,
    signs = false,
    severity_sort = true,
    underline = false,
})

-- Handlers --
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = false,
        virtual_text = true,
        signs = false,
        severity_sort = true,
})

vim.lsp.handlers['textDocument/definition'] = function (err, result, ctx, config)
    if err ~= nil then P(err) end
    local util = require('vim.lsp.util')
    if result == nil or vim.tbl_isempty(result) then
        if notify_installed then
            notify('No definitions found', 'info', {
                title = ' LSP',
                timeout = 1000,
            })
        end
    else
        -- textDocument/definition can return Location or Location[]
        -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition
        config = config or {}
        local client = vim.lsp.get_client_by_id(ctx.client_id)

        if vim.tbl_islist(result) then
          local title = ' LSP'
          local items = util.locations_to_items(result, client.offset_encoding)

            if #result == 1 then
                util.jump_to_location(result[1], client.offset_encoding, config.reuse_win)
                return
            else
                vim.fn.setloclist(0, {}, ' ', { title = title, items = items })
                vim.cmd [[Trouble loclist]]
            end
        else
            util.jump_to_location(result, client.offset_encoding, config.reuse_win)
        end
    end
end

vim.lsp.handlers['textDocument/references'] = function(err, result, ctx, config)
    if err ~= nil then P(err) end
    local util = require('vim.lsp.util')
    if not result or vim.tbl_isempty(result) then
        if notify_installed then
            notify('No references found', 'info', {
                title = ' LSP',
                timeout = 1000,
            })
        end
    else
        config = config or {}
        local client = vim.lsp.get_client_by_id(ctx.client_id)

          local title = ' LSP'
          local items = util.locations_to_items(result, client.offset_encoding)

        if #result == 1 then
            if notify_installed then
                notify('No other references', 'info', {
                    title = title,
                    timeout = 1000,
                })
            end
        else
            vim.fn.setloclist(0, {}, ' ', { title = title, items = items, context = ctx })
            vim.cmd [[Trouble loclist]]
        end
    end
end

-- vim.lsp.handlers['$/progress'] = function(_, result, ctx, _)
--     P(result)
-- end
