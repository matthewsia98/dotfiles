local ai_installed, ai = pcall(require, "mini.ai")

if ai_installed then
    ai.setup({
        custom_textobjects = {},
        mappings = {
            around_next = "an",
            inside_next = "in",
            around_last = "al",
            inside_last = "il",

            goto_left = "g[",
            goto_right = "g]",
        },
        -- Number of lines within which textobject is searched
        n_lines = 500,

        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
        search_method = "cover_or_next",
    })
end

local cursorword_installed, cursorword = pcall(require, "mini.cursorword")
if cursorword_installed then
    cursorword.setup({
        delay = 0,
    })
end

-- local align_installed, align = pcall(require, "mini.align")
-- if align_installed then
--     align.setup({
--         mappings = {
--             start = "ga",
--             start_with_preview = "gA",
--         },
--     })
-- end
