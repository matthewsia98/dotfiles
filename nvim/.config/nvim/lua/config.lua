local config = {
    lualine = {
        style = "box", -- powerline | box | round | slant | reverse_slant
        gap_between_sections = true,
        diagnostics = {
            max_length = 60,
            icon = false,
            source = false,
        },
    },

    leap = {
        forward_key = ";",
        backward_key = "-",
    },

    diagnostic = {
        virtual_text = true,
    },

    lsp = {
        -- Go to definition, reference, type definition
        goto_provider = "trouble", -- trouble | telescope | lspsaga | builtin

        -- Code action, hover, rename, diagnostics
        actions_provider = "builtin", -- lspsaga | builtin

        lsps_to_configure = {
            -- "pylsp",
            "pyright",
            "lua_ls",
            "jdtls",
            "clangd",
            "gopls",
            "rust_analyzer",
        },

        mason_packages_to_install = {
            -- Python
            "python-lsp-server", -- includes { "autopep8", "flake8", "mccabe", "pycodestyle", "pydocstyle", "pyflakes", "pylint", "rope", { "yapf", "whatthepatch" } }
            "pyright",
            "black",
            "isort",

            -- Lua
            "lua-language-server",
            "stylua",

            -- Java
            "jdtls",

            -- GO
            "gopls",
            "gofumpt",

            -- C/C++
            "clangd",
            "clang-format",

            -- Rust
            "rust-analyzer",
            "rustfmt",
        },

        null_ls_sources = {
            formatting = {
                "black",
                "isort",
                "stylua",
                "gofumpt",
                "rustfmt",
                "clang_format",
            },
        },

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
