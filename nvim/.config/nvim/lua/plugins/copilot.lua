return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            panel = { enabled = false },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = false,
                    accept_word = false,
                    accept_line = false,
                    next = false,
                    prev = false,
                    dismiss = false,
                }
            },
            server_opts_overrides = {
                settings = {
                    advanced = {
                        inlineSuggestCount = 5,
                    }
                }
            }
        })
    end,
}
