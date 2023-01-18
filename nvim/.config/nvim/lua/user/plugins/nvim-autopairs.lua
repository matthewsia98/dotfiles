local installed, npairs = pcall(require, "nvim-autopairs")

if installed then
    npairs.setup({
        enable_check_bracket_line = true,
        -- check_ts = true,
        -- ts_config = {
        --     lua = { "string" }, -- it will not add a pair on that treesitter node
        --     javascript = { "template_string" },
        --     java = false, -- don't check treesitter on java
        -- },
    })
end
