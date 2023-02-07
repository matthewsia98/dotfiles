local M = {}

M.make_config_file = function(lsp_name)
    -- Automatically create ~/.config/nvim/lua/user/plugins/lsp/nvim-lspconfig/<server-name>.lua
    local servers_dir = vim.fn.expand("~/.config/nvim/lua/plugins/lsp/servers/")
    local dir_exists = vim.fn.isdirectory(servers_dir) ~= 0
    if not dir_exists then
        vim.fn.mkdir(servers_dir, "p")
    end

    local config_file = vim.fn.expand("~/.config/nvim/lua/plugins/lsp/servers/" .. lsp_name .. ".lua")
    local file_exists = vim.fn.filereadable(config_file) ~= 0

    if not file_exists then
        local file = io.open(config_file, "w")
        if file then
            local content = string.format(
                [[
local M = {}

M.setup = function(opts)
    local lspconfig = require("lspconfig")
    lspconfig["%s"].setup({
        capabilities = opts.capabilities,
        flags = opts.flags,
        handlers = opts.handlers,
        on_attach = opts.on_attach,

        settings = {},
    })
end

return M]],
                lsp_name
            )
            file:write(content)
            file:close()
        end
    end
end

return M
