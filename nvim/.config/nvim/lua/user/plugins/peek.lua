local installed, peek = pcall(require, "peek")
if installed then
    peek.setup({
        auto_load = true, -- whether to automatically load preview when entering another markdown buffer
        close_on_bdelete = true, -- close preview window on buffer delete

        syntax = true, -- enable syntax highlighting, affects performance

        theme = "dark", -- 'dark' or 'light'

        update_on_change = true,

        -- relevant if update_on_change is true
        throttle_at = 200000, -- start throttling when file exceeds this amount of bytes in size
        throttle_time = "auto", -- minimum amount of time in milliseconds that has to pass before starting new render
    })

    local keys = require("user.keymaps")

    keys.map("n", "<leader>md", function()
        if peek.is_open() then
            vim.fn.system("hyprctl keyword misc:enable_swallow 1")
            peek.close()
        else
            vim.fn.system("hyprctl keyword misc:enable_swallow 0")
            peek.open()
        end
    end, { desc = "Toggle peek" })
end
