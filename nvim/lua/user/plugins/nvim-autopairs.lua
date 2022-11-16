local installed, npairs = pcall(require, "nvim-autopairs")

if installed then
    npairs.setup({
        check_ts = true,
    })
end
