local installed, copilot = pcall(require, "copilot")

if installed then
    copilot.setup({
        panel = {
            enabled = true,
            auto_refresh = false,
            keymap = {
                jump_prev = "<C-p>",
                jump_next = "<C-n>",
                accept = "<CR>",
                refresh = "r",
                open = "<M-C-CR>",
            },
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
                accept = "<C-Space>",
                accept_word = false,
                accept_line = false,
                next = "<C-n>",
                prev = "<C-p>",
                dismiss = "<C-c>",
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
                    inlineSuggestCount = 3, -- #completions for getCompletions
                },
            },
        },
    })
end
