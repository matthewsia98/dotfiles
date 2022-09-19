local installed, _ = pcall(require, 'lspconfig')

if installed then
    local notify_installed, notify = pcall(require, 'notify')

    local on_attach = function(client, bufnr)
        -- local root_dir = client["config"]["root_dir"]
        -- local filepath = vim.fn.expand("%")
        --
        -- local msg = { "Language Server: " .. client["name"] }
        -- if root_dir then
        -- 	table.insert(msg, "Root Directory: " .. client["config"]["root_dir"])
        -- else
        -- 	table.insert(msg, "Root Directory: " .. filepath .. " (Single file mode)")
        -- end
        --
        -- if client["name"] == "pylsp" then
        -- 	local env = vim.env.VIRTUAL_ENV or "/usr"
        -- 	table.insert(msg, "Jedi Environment: " .. env)
        -- end
        --
        -- if notify_installed then
        -- 	notify(msg, "info", {
        -- 		title = " LSP",
        -- 		timeout = 1000,
        -- 	})
        -- end

        local keys = require('user.keymaps')
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
        -- keys.map('n', '<leader>s', vim.lsp.buf.signature_help, bufopts)
        keys.map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
        keys.map({ 'n', 'v' }, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
        keys.map('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>', bufopts)
        -- keys.map('v', '<leader>fm', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', bufopts)
        keys.map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', bufopts)
        keys.map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', bufopts)
        keys.map('n', '<leader>wls', function()
            P(vim.lsp.buf.list_workspace_folders())
        end, bufopts)
    end

    local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    }

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- local progress_ns_id = vim.api.nvim_create_namespace("")
    --    local progress_hl_group = 'DiagnosticVirtualTextInfo'
    --    local begins = {}
    --    local begin_count = 0

    local handlers = {
        -- ["$/progress"] = function(_, result, ctx)
        -- 	local client_id = ctx.client_id
        -- 	local client = vim.lsp.get_client_by_id(client_id)
        -- 	local client_name = client.name
        --
        --           local token = result.token
        --           local value = result.value
        --
        --           if value.kind == 'begin' then
        --               local offset = 2
        --               if begin_count > 0 then
        --                   offset = 3 * begin_count + 3
        --               end
        --
        --               local title_text = value.title
        --               local message_text = value.message
        --               if value.percentage then
        --                   message_text = value.message .. ' (' .. value.percentage .. '%)'
        --               end
        --               local max_length = math.max(#title_text, #message_text, #client_name)
        --               local client_text = string.format(' %-' .. max_length .. 's ', client_name)
        --               title_text = string.format(' %-' .. max_length .. 's ', title_text)
        --               message_text = string.format(' %-' .. max_length .. 's ', message_text)
        --               if vim.fn.line('w$') - offset - 2 >= 0 then
        --                   local server_extmark = vim.api.nvim_buf_set_extmark(0, progress_ns_id, vim.fn.line('w$') - offset - 2, -1, {
        --                       virt_text = {
        --                           { client_text, progress_hl_group},
        --                       },
        --                       virt_text_pos = 'right_align',
        --                   })
        --                   local title_extmark = vim.api.nvim_buf_set_extmark(0, progress_ns_id, vim.fn.line('w$') - offset - 1, -1, {
        --                       virt_text = {
        --                           { title_text, progress_hl_group},
        --                       },
        --                       virt_text_pos = 'right_align',
        --                   })
        --                   local message_extmark = vim.api.nvim_buf_set_extmark(0, progress_ns_id, vim.fn.line('w$') - offset, -1, {
        --                       virt_text = {
        --                           { message_text, progress_hl_group},
        --                       },
        --                       virt_text_pos = 'right_align',
        --                   })
        --
        --                   table.insert(begins, {
        --                       order = begin_count,
        --                       token = token,
        --                       title = value.title,
        --                       message = value.message,
        --                       percentage = value.percentage,
        --                       server_extmark = server_extmark,
        --                       title_extmark = title_extmark,
        --                       message_extmark = message_extmark,
        --                   })
        --
        --                   begin_count = begin_count + 1
        --               end
        --           elseif value.kind == 'report' then
        --               for _, begin in pairs(begins) do
        --                   if begin.token == token then
        --                       local offset
        --                       if begin.order == 0 then
        --                           offset = 2
        --                       else
        --                           offset = 3 * begin.order + 3
        --                       end
        --
        --                       local title_text = begin.title
        --                       local message_text = value.message .. ' (' .. value.percentage .. '%)'
        --                       local max_length = math.max(#title_text, #message_text)
        --                       local client_text = string.format(' %-' .. max_length .. 's ', client_name)
        --                       title_text = string.format(' %-' .. max_length .. 's ', title_text)
        --                       message_text = string.format(' %-' .. max_length .. 's ', message_text)
        --                       vim.api.nvim_buf_set_extmark(0, progress_ns_id, vim.fn.line('w$') - offset - 2, -1, {
        --                           id = begin.server_extmark,
        --                           virt_text = {
        --                               { client_text, progress_hl_group},
        --                           },
        --                           virt_text_pos = 'right_align',
        --                       })
        --                       vim.api.nvim_buf_set_extmark(0, progress_ns_id, vim.fn.line('w$') - offset - 1, -1, {
        --                           id = begin.title_extmark,
        --                           virt_text = {
        --                               { title_text, progress_hl_group},
        --                           },
        --                           virt_text_pos = 'right_align',
        --                       })
        --                       vim.api.nvim_buf_set_extmark(0, progress_ns_id, vim.fn.line('w$') - offset, -1, {
        --                           id = begin.message_extmark,
        --                           virt_text = {
        --                               { message_text, progress_hl_group},
        --                           },
        --                           virt_text_pos = 'right_align',
        --                       })
        --                       break
        --                   end
        --               end
        --           elseif value.kind == 'end' then
        --               vim.defer_fn(function()
        --                   -- vim.api.nvim_buf_clear_namespace(0, progress_ns_id, 0, -1)
        --                   for _, begin in pairs(begins) do
        --                       vim.api.nvim_buf_del_extmark(0, progress_ns_id, begin.server_extmark)
        --                       vim.api.nvim_buf_del_extmark(0, progress_ns_id, begin.title_extmark)
        --                       vim.api.nvim_buf_del_extmark(0, progress_ns_id, begin.message_extmark)
        --                   end
        --               end, 2000)
        --           end
        --       end,

        ['textDocument/definition'] = function(err, result, ctx, config)
            if err ~= nil then
                P(err)
                return
            end

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
                        vim.cmd([[Trouble loclist]])
                    end
                else
                    util.jump_to_location(result, client.offset_encoding, config.reuse_win)
                end
            end
        end,
        ['textDocument/references'] = function(err, result, ctx, _)
            if err ~= nil then
                P(err)
                return
            end

            local util = require('vim.lsp.util')
            if not result or vim.tbl_isempty(result) then
                if notify_installed then
                    notify('No references found', 'info', {
                        title = ' LSP',
                        timeout = 1000,
                    })
                end
            else
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
                    vim.cmd([[Trouble loclist]])
                end
            end
        end,
    }

    require('user.plugins.lsp.nvim-lspconfig.pylsp').setup(on_attach, lsp_flags, capabilities, handlers)
    require('user.plugins.lsp.nvim-lspconfig.sumneko-lua').setup(on_attach, lsp_flags, capabilities, handlers)
    require('user.plugins.lsp.nvim-lspconfig.jdtls').setup(on_attach, lsp_flags, capabilities, handlers)
end
