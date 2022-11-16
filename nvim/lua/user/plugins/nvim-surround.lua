local installed, nvim_surround = pcall(require, "nvim-surround")

if installed then
    nvim_surround.setup({
        aliases = {
            ["b"] = { ")", "}" },
        },
    })
end
