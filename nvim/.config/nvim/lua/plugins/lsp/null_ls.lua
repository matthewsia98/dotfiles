local config = require("config")

local null_ls = require("null-ls")
local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

local sources = {}
for source_type, type_sources in pairs(config.lsp.null_ls_sources) do
    for k, v in pairs(type_sources) do
        local source = type(k) == "string" and k or v
        local opts = type(k) == "string" and v or {}
        table.insert(sources, null_ls.builtins[source_type][source].with(opts))
    end
end

null_ls.setup({
    sources = sources,
    border = "rounded",
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = group,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ name = "null-ls", timeout = 5000 })
                end,
            })
        end
    end,
})
