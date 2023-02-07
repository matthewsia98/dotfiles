local config = {
    lualine = {
        style = "slant",
        gap_between_sections = true,
        diagnostics = {
            max_length = 100,
            icon = true,
            source = true,
        },
    },

    lsp = {
        goto_provider = "trouble",

        lsps_to_configure = {
            "pylsp",
            -- "pyright",
            "sumneko_lua",
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
