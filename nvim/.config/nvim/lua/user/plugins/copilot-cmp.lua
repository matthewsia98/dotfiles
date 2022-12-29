local installed, copilot = pcall(require, "copilot_cmp")

if installed then
    copilot.setup()
end
