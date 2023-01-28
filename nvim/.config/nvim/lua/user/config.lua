local config = {
    lualine = {
        transparent_bg = true,
        gap_between_sections = true,
        separator_style = "slant", -- "box", "powerline", "round", "reverse_slant", "slant"
        max_diagnostic_length = 70,
    },

    leap = {
        forward_key = ";",
        backward_key = "-",
    },

    lsp = {
        -- Use lspsaga for go to definition, references, hover, etc. Otherwise use built-in or trouble
        prefer_lspsaga = false,

        -- Must have corresponding ~/.config/nvim/lua/user/plugins/lsp/nvim-lspconfig/<server-name>.lua
        lsps_to_configure = {
            "pylsp",
            "sumneko_lua",
            "jdtls",
            "clangd",
            "gopls",
        },

        mason_packages_to_install = {
            -- Python
            "python-lsp-server", -- includes { "autopep8", "flake8", "mccabe", "pycodestyle", "pydocstyle", "pyflakes", "pylint", "rope", { "yapf", "whatthepatch" } }
            "black",
            "isort",

            -- Lua
            "lua-language-server",
            "stylua",

            -- Java
            "jdtls",

            -- GO
            "gopls",

            -- C/C++
            "clangd",
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
    },
}

return config
