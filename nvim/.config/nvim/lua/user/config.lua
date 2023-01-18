local config = {
    lualine_transparent_bg = true,
    lualine_gap_between_sections = true,
    lualine_separator_style = "box", -- "box", "powerline", "round", "reverse_slant", "slant"

    prefer_lspsaga = true,

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

    pylsp_plugins_to_install = {
        "pylsp-mypy",
        "pyls-isort",
        "python-lsp-black",
        "pylsp-rope",
        "python-lsp-ruff",
    },
}

return config
