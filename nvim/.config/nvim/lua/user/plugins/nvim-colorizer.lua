local installed, colorizer = pcall(require, "colorizer")

if installed then
    colorizer.setup({
        user_default_options = {
            names = false,
        },
    })
end
