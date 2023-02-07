local config = {
    colorscheme = {
        name = "catppuccin",
        sync_kitty = true,
    },

    lualine = {
        gap_between_sections = true,
        separator_style = "slant", -- "box", "powerline", "round", "reverse_slant", "slant"
        max_diagnostic_length = 80,
    },

    leap = {
        forward_key = ";",
        backward_key = "-",
    },

    lsp = {
        -- Enable neodev for vim api completion (Slows down lua language server)
        enable_neodev = true,

        -- Use lspsaga for go to definition, references, hover, etc. Otherwise use built-in or trouble
        prefer_lspsaga = true,

        -- Use virtual text if true. Otherwise use cmp menu
        copilot = {
            auto_trigger = true,
        },

        --  Configured in ~/.config/nvim/lua/user/plugins/lsp/nvim-lspconfig/<server-name>.lua
        -- <server-name> should match those from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        lsps_to_configure = {
            "pylsp",
            -- "pyright",
            "sumneko_lua",
            "jdtls",
            "clangd",
            "gopls",
            "rust_analyzer",
        },

        -- names should match those from https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
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

        -- names should match those from https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md
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
