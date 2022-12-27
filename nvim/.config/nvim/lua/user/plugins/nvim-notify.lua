local installed, notify = pcall(require, "notify")

if installed then
    notify.setup({
        timeout = 3000,
    })
    vim.notify = notify
end
