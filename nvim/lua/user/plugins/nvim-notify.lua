local installed, notify = pcall(require, "notify")

if installed then
    vim.notify = notify
end

