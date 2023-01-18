local installed, neoscroll = pcall(require, "neoscroll")

if installed then
    neoscroll.setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        -- mappings = {},
        mappings = { "<C-u>", "<C-d>", "<C-f>", "<C-b>" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
    })

    -- local keys = require("user.keymaps")
    --
    -- keys.map({ "n", "i", "v" }, "<C-F>", function()
    --     neoscroll.scroll(vim.wo.scroll, true, 250)
    -- end ,{ desc = "Scroll forward" })
    -- keys.map({ "n", "i", "v" }, "<C-B>", function()
    --     neoscroll.scroll(-vim.wo.scroll, true, 250)
    -- end, { desc = "Scroll backward" })
end
