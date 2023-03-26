local config = {
    statusline = "lualine",

    lualine = {
        style = "box", -- box | round | slant | reverse_slant
        styles = {
            slant = { left = "", right = "" },
            reverse_slant = { left = "", right = "" },
            round = { left = "", right = "" },
            box = { left = "▐", right = "▌" },
            -- box = { left = "█", right = "█" },
        },

        gap_between_sections = true,

        diagnostics = {
            max_length = 60,
            icon = false,
            source = false,
        },

        winbar = {
            separator = " > ",
            navic = {
                enabled = true,
            },
            cwd = {
                enabled = true,
                highlight = "lualine_a_normal",
                home_symbol = "~",
            },
            trouble = {
                enabled = true,
                highlight = "lualine_a_normal",
            },
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
            "bashls",
            "html",
            "cssls",
            "emmet_ls",
            "tsserver",
            "jsonls",
        },

        mason_packages_to_install = {
            -- Python
            "python-lsp-server", -- includes { "autopep8", "flake8", "mccabe", "pycodestyle", "pydocstyle", "pyflakes", "pylint", "rope", { "yapf", "whatthepatch" } }
            "pyright",
            "black",
            "isort",
            "debugpy",

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

            -- Shell
            "bash-language-server",
            "shellcheck",
            "shfmt",

            -- JSON
            "json-lsp",
            "jq",

            -- HTML / CSS / JS
            "html-lsp",
            "css-lsp",
            "emmet-ls",
            "typescript-language-server",
            "prettier",
        },

        null_ls_sources = {
            formatting = {
                --Python
                "black",
                "isort",

                -- Lua
                "stylua",

                -- Go
                "gofumpt",

                -- Rust
                "rustfmt",

                -- C/C++
                "clang_format",

                -- Shell
                "shfmt",

                -- JSON
                ["jq"] = { args = { "--indent", "4" } },

                "prettier",
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
