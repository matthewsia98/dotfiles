return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
        suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = { accept = "<C-SPACE>", dismiss = "<C-C>" },
        },
    },
}
