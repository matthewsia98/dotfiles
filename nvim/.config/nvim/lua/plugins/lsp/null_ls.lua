local null_ls = require("null-ls")

local config = {
    diagnostics = {
        -- Python
        "djlint",

        -- Lua
        "luacheck",
    },

    formatting = {
        --Python
        "black",
        "isort",
        "djlint",

        -- Lua
        "stylua",

        -- Java
        ["google_java_format"] = { extra_args = { "--aosp" } },

        -- Go
        "gofumpt",

        -- Rust
        "rustfmt",

        -- C/C++
        "clang_format",

        -- Shell
        "shfmt",

        -- JSON
        ["jq"] = { extra_args = { "--indent", "4" } },

        "prettier",
    },
}

local sources = {}
for source_type, type_sources in pairs(config) do
    for k, v in pairs(type_sources) do
        local source = type(k) == "string" and k or v
        local opts = type(k) == "string" and v or {}
        table.insert(sources, null_ls.builtins[source_type][source].with(opts))
    end
end

null_ls.setup({
    border = "rounded",
    sources = sources,
    on_attach = function(client, bufnr)
        local map = require("keymaps").map

        if client.supports_method("textDocument/formatting") then
            map("n", "<leader>fm", function()
                vim.lsp.buf.format({ name = "null-ls" })
            end, { buffer = bufnr, desc = "Format" })

            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ name = "null-ls", timeout_ms = 3000 })
                end,
            })
        end
    end,
})
