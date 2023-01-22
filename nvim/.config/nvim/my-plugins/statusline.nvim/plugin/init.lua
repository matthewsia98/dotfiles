local statusline = require("statusline")

statusline.setup_highlight_groups()
vim.o.statusline = [[%{%v:lua.require('statusline').update_statusline()%}]]
