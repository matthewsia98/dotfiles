local cursor_installed, cursorword = pcall(require, "mini.cursorword")
if cursor_installed then
    cursorword.setup({
        delay = 0,
    })
end

local align_installed, align = pcall(require, "mini.align")
if align_installed then
    align.setup({
        mappings = {
            start = "ga",
            start_with_preview = "gA",
        },
    })
end
