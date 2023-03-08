return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        notify.setup({
            timeout = 1000,
        })
        vim.notify = notify
    end,
}
