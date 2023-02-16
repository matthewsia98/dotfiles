local null_ls = require("null-ls")

local config = require("config")
local sources = {}
for type, type_sources in pairs(config.lsp.null_ls_sources) do
    for _, source in ipairs(type_sources) do
        table.insert(sources, null_ls.builtins[type][source])
    end
end

null_ls.setup({
    sources = sources,
    border = "rounded",
})
