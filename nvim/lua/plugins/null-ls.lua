local null_ls = require('null-ls')
local null_ls_sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
}
null_ls.setup({
    sources =  null_ls_sources
})
