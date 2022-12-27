if vim.g.started_by_firenvim then
    vim.g.firenvim_config = {
        localSettings = {
            [".*"] = {
                cmdline = "none"
            },
        },
    }
    vim.opt.laststatus = 0
    vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
            vim.go.lines = 20
        end,
    })
end
