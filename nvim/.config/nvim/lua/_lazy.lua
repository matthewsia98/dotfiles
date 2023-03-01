local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("lazy_check_updates", { clear = true }),
    pattern = "lazy",
    callback = function()
        require("lazy.manage").check()
    end,
    desc = "Check for updates on open",
})

require("lazy").setup("plugins", {
    defaults = {
        lazy = true,
    },
    dev = {
        path = "~/repos",
    },
    install = {
        colorscheme = { "catppuccin" },
    },
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    ui = {
        border = "rounded",
    },
})
