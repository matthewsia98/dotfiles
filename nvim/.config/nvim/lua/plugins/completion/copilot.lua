require("copilot").setup({
    panel = { enabled = false },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        -- Keymaps defined in ~/.config/nvim/lua/plugins/completion/keymaps.lua
        keymap = {
            accept = false,
            accept_word = false,
            accept_line = false,
            next = false,
            prev = false,
            dismiss = false,
        },
    },
    server_opts_overrides = {
        settings = {
            advanced = {
                inlineSuggestCount = 5,
            },
        },
    },
})
