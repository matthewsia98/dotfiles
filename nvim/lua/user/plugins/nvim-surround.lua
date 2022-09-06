local installed, nvim_surround = pcall(require, 'nvim-surround')

if installed then
    nvim_surround.setup()

    vim.cmd [[highlight default link NvimSurroundHighlight Visual]]
end
