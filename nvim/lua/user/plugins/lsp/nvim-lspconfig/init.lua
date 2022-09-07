local installed, _ = pcall(require, 'lspconfig')
local keys = require('user.keymaps')

if installed then
    local on_attach = function(client, bufnr)
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

        local notify_installed, notify = pcall(require, 'notify')
        if notify_installed then
            notify(msg, 'info', {
                title = ' LSP',
                timeout = 1000,
            })
        end

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        keys.map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
        keys.map('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', bufopts)
        keys.map('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', bufopts)
        keys.map('n', '<leader>dll', '<cmd>lua vim.diagnostic.setloclist()<CR>', bufopts)
        keys.map('n', '<leader>dqf', '<cmd>lua vim.diagnostic.setqflist()<CR>', bufopts)
        keys.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', bufopts)
        keys.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
        keys.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)
        keys.map('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', bufopts)
        keys.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufopts)
        keys.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopts)
        -- map('n', '<leader>s', vim.lsp.buf.signature_help, bufopts)
        keys.map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
        keys.map({'n', 'v'}, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
        keys.map('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>', bufopts)
        keys.map('x', '<leader>fm', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', bufopts)
        keys.map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', bufopts)
        keys.map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', bufopts)
        keys.map('n', '<leader>wls', function() P(vim.lsp.buf.list_workspace_folders()) end, bufopts)
    end

    local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    }

    local capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    require('user.plugins.lsp.nvim-lspconfig.pylsp').setup(on_attach, lsp_flags, capabilities)
    require('user.plugins.lsp.nvim-lspconfig.sumneko-lua').setup(on_attach, lsp_flags, capabilities)
    require('user.plugins.lsp.nvim-lspconfig.jdtls').setup(on_attach, lsp_flags, capabilities)
end
