vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git", lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

local lazy = require("lazy")
lazy.setup({

})

vim.cmd([[highlight default Normal guibg=#000000]])
vim.cmd([[highlight default NormalFloat guibg=#000000]])
