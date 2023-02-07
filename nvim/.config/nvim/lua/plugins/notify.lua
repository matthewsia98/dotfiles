return {
    "rcarriga/nvim-notify",
    config = function()
        local notify = require("notify")
        notify.setup({
            timeout = 3000,
        })
        vim.notify = notify
    end,
}
