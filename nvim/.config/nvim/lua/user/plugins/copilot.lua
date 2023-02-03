local installed, copilot = pcall(require, "copilot")

if installed then
    local config = require("user.config")

    copilot.setup({
        panel = {
            enabled = false,
            auto_refresh = false,
            keymap = {
                jump_prev = "<C-p>",
                jump_next = "<C-n>",
                accept = "<CR>",
                refresh = "R",
                open = "<M-C-CR>",
            },
        },
        suggestion = {
            enabled = config.lsp.auto_trigger,
            auto_trigger = config.lsp.auto_trigger,
            debounce = 75,
            -- Keymap defined in nvim-cmp.lua
            keymap = {
                accept = false,
                accept_word = false,
                accept_line = "<C-CR>",
                next = false,
                prev = false,
                dismiss = false,
            },
        },
        filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {
            settings = {
                advanced = {
                    listCount = 5, -- #completions for panel
                    inlineSuggestCount = 5, -- #completions for getCompletions
                },
            },
        },
    })
end
