local config = {
    lualine_transparent_bg = true,
    lualine_gap_between_sections = true,
    lualine_separator_style = "box", -- "box", "powerline", "round", "reverse_slant", "slant"
    lualine_max_diagnostic_msg_length = 100,

    prefer_lspsaga = false,

    lsps_to_configure = {
        "pylsp",
        "sumneko_lua",
        "jdtls",
    },

    mason_packages_to_install = {
        "python-lsp-server", -- includes { "autopep8", "flake8", "mccabe", "pycodestyle", "pydocstyle", "pyflakes", "pylint", "rope", { "yapf", "whatthepatch" } }
        -- "flake8",
        -- "mypy",
        -- "pydocstyle",
        "black",
        "isort",

        "lua-language-server",
        -- "luacheck",
        "stylua",

        "jdtls",
    },

    --[[
    If language server is updated, plugins need to be manually reinstalled
    source ~/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/activate
    pip install pylsp-mypy pyls-isort python-lsp-black pylsp-rope python-lsp-ruff
    ]]
    pylsp_plugins_to_install = {
        "pylsp-mypy",
        "pyls-isort",
        "python-lsp-black",
        "pylsp-rope",
        "python-lsp-ruff",
    },
}

return config
