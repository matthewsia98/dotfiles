local M = {}

M.expand_node = function(line_to_cursor, matched_trigger, captures)
    local _, row, col, _, _ = unpack(vim.fn.getcurpos())
    local node = vim.treesitter.get_node({
        pos = { row - 1, col - #matched_trigger - 1 },
    })

    local no_expand_nodes = {
        "comment",
        "string",
        "string_literal",
    }

    return node and not vim.tbl_contains(no_expand_nodes, node:type())
end

return M
