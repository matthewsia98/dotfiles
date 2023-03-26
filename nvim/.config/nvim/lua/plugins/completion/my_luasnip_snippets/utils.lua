local M = {}

M.not_in_comment_node = function(line_to_cursor, matched_trigger, captures)
    local _, row, col, _, _ = unpack(vim.fn.getcurpos())
    local node = vim.treesitter.get_node({
        pos = { row - 1, col - #matched_trigger - 1 },
    })
    return node and node:type() ~= "comment"
end

return M
