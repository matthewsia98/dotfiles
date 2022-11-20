local installed, twilight = pcall(require, "twilight")

if installed then
    twilight.setup({

    })

    vim.cmd [[ TwilightEnable ]]
end
