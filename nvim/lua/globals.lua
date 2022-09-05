function P(item)
    print(vim.inspect(item))
end

function R(name)
    require('plenary.reload').reload_module(name)
    return require(name)
end

function map(mode, key, value, options)
    options = options or { silent = true, noremap = true }
    vim.keymap.set(mode, key, value, options)
end

function unmap(mode, key, options)
    vim.keymap.del(mode, key, options)
end
