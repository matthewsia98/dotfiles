return {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    ft = "jupynium",
    config = function()
        require("jupynium").setup({
            python_host = "python3",
            firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
        })
    end,
}
