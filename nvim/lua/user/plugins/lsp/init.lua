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
    underline = true,
})
