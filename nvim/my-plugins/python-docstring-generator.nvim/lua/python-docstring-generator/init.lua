local M = {}

local q = require('vim.treesitter.query')
local bufnr = vim.api.nvim_get_current_buf()
local language_tree = vim.treesitter.get_parser(bufnr, 'python')
local query = vim.treesitter.parse_query('python', [[
(function_definition
    name: (identifier)
    parameters: (parameters
        ;; (identifier)* @arg
        ;; (typed_parameter)* @typed_arg
        ;; (default_parameter)* @kwarg
        ;; (typed_default_parameter)* @typed_kwarg
    ) @parameters
    return_type: (type)? @return_type
    body: (block)
) @function
]])

M.generate_docstrings = function()
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[1]:root()

    local lines_to_insert = {}
    local num_lines_inserted = 0
    for pattern, match in query:iter_matches(root, bufnr) do
        local has_docstring = false
        local inserted_args
        local inserted_kwargs
        local parameters_end_row
        local docstring = {}
        -- print('Pattern', pattern)
        for capture_id, node in pairs(match) do
            local capture_name = query.captures[capture_id]
            local node_text = q.get_node_text(node, bufnr)
            local node_type = node:type()
            -- print('Capture ID:', capture_id, '    Capture Name:', capture_name, '    Node Type:', node_type)
            -- print('    Node Text:', node_text)
            if capture_name == 'function' then
                local body = node:field('body')[1]
                if body:child(0):child(0):type() == 'string' then
                    has_docstring = true
                end
            elseif capture_name == 'return_type' then
                table.insert(docstring, '')
                table.insert(docstring, 'Returns:')
                table.insert(docstring, '    ' .. node_text)
            elseif capture_name == 'parameters' then
                local parameters_text = q.get_node_text(node, bufnr)
                _, _, parameters_end_row = node:range()
                if parameters_text ~= '()' and parameters_text ~= '(self)' then
                    for child in node:iter_children() do
                        local child_type = child:type()
                        local child_text = q.get_node_text(child, bufnr)
                        if child:named() then
                            local text
                            local kwarg_default_value
                            if child_type == 'identifier' then
                                -- arg
                                if not inserted_args then
                                    table.insert(docstring, 'Args:')
                                    inserted_args = true
                                end
                                if child_text ~= 'self' then
                                    text = child_text .. ':'
                                end
                            elseif child_type == 'typed_parameter' then
                                if not inserted_args then
                                    table.insert(docstring, 'Args:')
                                    inserted_args = true
                                end
                                local arg_name = q.get_node_text(child:child(0), bufnr)
                                local arg_type = q.get_node_text(child:field('type')[1], bufnr)
                                text = string.format([[%s (%s):]], arg_name, arg_type)
                            elseif child_type:match('default_parameter') then
                                if not inserted_kwargs then
                                    table.insert(docstring, '')
                                    table.insert(docstring, 'Kwargs:')
                                    inserted_kwargs = true
                                end
                                local arg_name = q.get_node_text(child:field('name')[1], bufnr)
                                local arg_value = q.get_node_text(child:field('value')[1], bufnr)
                                local arg_type
                                if child_type == 'typed_default_parameter' then
                                    arg_type = q.get_node_text(child:field('type')[1], bufnr)
                                end
                                if arg_type then
                                    text = string.format([[%s (%s):]], arg_name, arg_type)
                                else
                                    text = arg_name .. ':'
                                end
                                kwarg_default_value = 'Default Value = ' .. arg_value
                            end
                            if text ~= nil then
                                table.insert(docstring, '    ' .. text)
                            end
                            if kwarg_default_value then
                                table.insert(docstring, '        ' .. kwarg_default_value)
                            end
                        end
                    end
                end
            end
        end
        if not has_docstring and #docstring > 0 then
            local row = parameters_end_row + 1 + num_lines_inserted
            table.insert(lines_to_insert, {row, '"""'})
            num_lines_inserted = num_lines_inserted + 1
            for _, text in ipairs(docstring) do
                row = parameters_end_row + 1 + num_lines_inserted
                table.insert(lines_to_insert, {row, text})
                num_lines_inserted = num_lines_inserted + 1
            end
            row = parameters_end_row + 1 + num_lines_inserted
            table.insert(lines_to_insert, {row, '"""'})
            num_lines_inserted = num_lines_inserted + 1
        end
    end

    for _, line in ipairs(lines_to_insert) do
        if line[2] == '' then
            vim.api.nvim_buf_set_lines(bufnr, line[1], line[1], false, {line[2]})
        else
            vim.api.nvim_buf_set_lines(bufnr, line[1], line[1], false, {'    ' .. line[2]})
        end
    end
end

vim.api.nvim_create_user_command('PythonGenerateDocstrings', M.generate_docstrings, {})
vim.keymap.set('n', '<leader>pgd', '<cmd>PythonGenerateDocstrings<CR>')

return M
