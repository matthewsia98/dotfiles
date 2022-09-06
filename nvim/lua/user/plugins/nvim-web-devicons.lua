local installed, nvim_web_devicons = pcall(require, 'nvim-web-devicons')

if installed then
    nvim_web_devicons.setup()
end
