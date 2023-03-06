local config = require("config")

local null_ls = require("null-ls")
local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

local sources = {}
for type, type_sources in pairs(config.lsp.null_ls_sources) do
    for _, source in ipairs(type_sources) do
        if source == "jq" then
            table.insert(
                sources,
                null_ls.builtins[type][source].with({
                    args = { "--indent", "4" },
                })
            )
        else
            table.insert(sources, null_ls.builtins[type][source])
        end
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
                    vim.lsp.buf.format({ name = "null-ls" })
                end,
            })
        end
    end,
})
