local notify = require('notify')

on_attach = function(client, bufnr)
    local root_dir = client['config']['root_dir']
    local filepath = vim.fn.expand("%")

    local msg = { 'Language Server: ' .. client['name'] }
    if root_dir then
        table.insert(msg, 'Root Directory: ' .. client['config']['root_dir'])
    else
        table.insert(msg, 'Root Directory: ' .. filepath .. ' (Single file mode)')
    end

    if client['name'] == 'pylsp' then
        local env = vim.env.VIRTUAL_ENV or '/usr'
        table.insert(msg, 'Jedi Environment: ' .. env)
    end

    notify(msg, 'info', {
        title = ' LSP',
        timeout = 3000,
    })

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
    map('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', bufopts)
    map('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', bufopts)
    map('n', '<leader>dll', '<cmd>lua vim.diagnostic.setloclist()<CR>', bufopts)
    map('n', '<leader>dqf', '<cmd>lua vim.diagnostic.setqflist()<CR>', bufopts)
    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', bufopts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)
    map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', bufopts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
    -- map('n', '<leader>s', vim.lsp.buf.signature_help, bufopts)
    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
    map({'n', 'v'}, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
    map('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>', bufopts)
    map('x', '<leader>fm', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', bufopts)
    map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', bufopts)
    map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', bufopts)
    map('n', '<leader>wls', function() P(vim.lsp.buf.list_workspace_folders()) end, bufopts)
end

lsp_flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}

capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

handlers = {
    -- ['$/progress'] = function(_, result, ctx, _)
    --     P(result)
    -- end,
    ['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = false,
        virtual_text = true,
        signs = false,
        severity_sort = true,
    }),
    ['textDocument/definition'] = function (err, result, ctx, config)
        if err ~= nil then P(err) end
        local util = require('vim.lsp.util')
        if result == nil or vim.tbl_isempty(result) then
            notify('No definitions found', 'info', {
                title = ' LSP',
                timeout = 1000,
            })
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
    end,
    ['textDocument/references'] = function(err, result, ctx, config)
        if err ~= nil then P(err) end
        local util = require('vim.lsp.util')
        if not result or vim.tbl_isempty(result) then
            notify('No references found', 'info', {
                title = ' LSP',
                timeout = 1000,
            })
        else
            config = config or {}
            local client = vim.lsp.get_client_by_id(ctx.client_id)

              local title = ' LSP'
              local items = util.locations_to_items(result, client.offset_encoding)

            if #result == 1 then
                notify('No other references', 'info', {
                    title = title,
                    timeout = 1000,
                })
            else
                vim.fn.setloclist(0, {}, ' ', { title = title, items = items, context = ctx })
                vim.cmd [[Trouble loclist]]
            end
        end
    end
}

-- SIGNS
-- vim.fn.sign_define(
--     'DiagnosticSignError',
--     { texthl = 'DiagnosticSignError', text = '', numhl = 'DiagnosticSignError' }
-- )
-- vim.fn.sign_define(
--     'DiagnosticSignWarn',
--     { texthl = 'DiagnosticSignWarn', text = '', numhl = 'DiagnosticSignWarn' }
-- )
-- vim.fn.sign_define(
--     'DiagnosticSignHint',
--     { texthl = 'DiagnosticSignHint', text = '', numhl = 'DiagnosticSignHint' }
-- )
-- vim.fn.sign_define(
--     'DiagnosticSignInfo',
--     { texthl = 'DiagnosticSignInfo', text = '', numhl = 'DiagnosticSignInfo' }
-- )
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

require('user.plugins.nvim-lspconfig.pylsp')
require('user.plugins.nvim-lspconfig.sumneko-lua')
require('user.plugins.nvim-lspconfig.jdtls')
