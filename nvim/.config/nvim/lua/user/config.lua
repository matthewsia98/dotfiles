local config = {
    lualine = {
        transparent_bg = true,
        gap_between_sections = true,
        separator_style = "slant", -- "box", "powerline", "round", "reverse_slant", "slant"
        max_diagnostic_length = 80,
    },

    leap = {
        forward_key = ";",
        backward_key = "-",
    },

    lsp = {
        -- Use lspsaga for go to definition, references, hover, etc. Otherwise use built-in or trouble
        prefer_lspsaga = false,

        --  ~/.config/nvim/lua/user/plugins/lsp/nvim-lspconfig/<server-name>.lua
        -- <server-name> should match those from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        lsps_to_configure = {
            "pylsp",
            "sumneko_lua",
            "jdtls",
            "clangd",
            "gopls",
            "rust_analyzer",
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
