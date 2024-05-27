require("utils")
require("options")
require("autocmds")
require("keymaps")
if vim.fn.exists("g:vscode") == 0 then
    require("_lazy")
end
