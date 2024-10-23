local opt = vim.opt

-- Number of spaces that a <Tab> in the file counts for
opt.tabstop = 4
-- Number of spaces to use for each step of (auto)indent
opt.shiftwidth = 0 -- If 0, tabstop value if used
-- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
opt.softtabstop = -1 -- If negative, shiftwidth value is used

opt.listchars:append("lead:·")
opt.listchars:append("trail:·")
opt.listchars:append("tab:»·")
