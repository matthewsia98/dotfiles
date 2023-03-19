return {
    "nullchilly/fsread.nvim",
    cmd = { "FSRead", "FSToggle" },
    config = function()
        vim.g.flow_strength = 0.7 -- low: 0.3, middle: 0.5, high: 0.7 (default)
        vim.api.nvim_set_hl(0, "FSPrefix", { fg = "#cdd6f4" })
        vim.api.nvim_set_hl(0, "FSSuffix", { fg = "#6C7086" })
    end,
}
