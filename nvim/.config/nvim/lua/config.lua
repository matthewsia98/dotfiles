local config = {
    -- What to open when neovim is launched without arguments or with directory as argument
    file_manager = "oil", -- neo-tree | oil

    statusline = "lualine", -- feline | lualine

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
            "csharp_ls",
        },

        mason_packages_to_install = {
            -- Python
            "python-lsp-server", -- includes { "autopep8", "flake8", "mccabe", "pycodestyle", "pydocstyle", "pyflakes", "pylint", "rope", { "yapf", "whatthepatch" } }
            "pyright",
            "black",
            "isort",
            "debugpy",
            "djlint",

            -- Lua
            "lua-language-server",
            "luacheck",
            "stylua",

            -- Java
            "jdtls",
            "google-java-format",

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

            -- C#
            "csharp-language-server",
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
