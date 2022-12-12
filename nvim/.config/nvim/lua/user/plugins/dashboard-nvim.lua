local installed, db = pcall(require, "dashboard")
if installed then
    db.header_pad = 0
    db.center_pad = 0
    db.footer_pad = 1

    db.preview_file_path = "~/.config/nvim/ascii/doom-ascii"
    db.preview_command = "lolcat -F 0.2"
    db.preview_file_width = 80
    db.preview_file_height = 19

	db.custom_center = {
		{
			icon = "  ",
			desc = "Recent Files",
			action = "Telescope oldfiles",
			shortcut = "SPC f r",
		},
		{
			icon = "  ",
			desc = "Find File",
			action = "Telescope find_files find_command=rg,--hidden,--files",
			shortcut = "SPC f f",
		},
		{
			icon = "  ",
			desc = "File Browser",
			action = "NvimTreeToggle",
			shortcut = "SPC n t",
		},
	}
    local max_len = 0
    for _, v in pairs(db.custom_center) do
        local len = #v.desc
        if len > max_len then
            max_len = len
            v.desc = string.format("%-" .. max_len + 4 .. "s", v.desc)
        end
    end
    for _, v in pairs(db.custom_center) do
        v.desc = string.format("%-" .. max_len + 4 .. "s", v.desc)
    end
end
