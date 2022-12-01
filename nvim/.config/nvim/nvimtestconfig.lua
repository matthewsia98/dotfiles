vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local packer_installed, packer = pcall(require, "packer")
if not packer_installed then
    return
end

packer.startup({
    function(use)
        use "wbthomason/packer.nvim"

        use({
            "folke/noice.nvim",
            requires = {
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
            },
	    config = function()
		local installed, noice = pcall(require, "noice")
		if installed then
		    noice.setup({
			messages = {
			    enabled = true,
			},
			cmdline = {
			    enabled = true,
			    view = "cmdline_popup",
			},
		    })
		end
		vim.cmd [[ highlight default Normal guibg=#000000 ]]
	    end
        })

	if packer_bootstrap then
	    packer.sync()
	    packer.compile()
	end
    end
})
