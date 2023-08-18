-- set colorscheme here
local colorscheme = "gruvbox"

-- set the color scheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

-- local base = "/home/al/.config/nvim/lua/al/ui/theme"
-- local base1 = "lua/al/ui/theme"

-- vim.cmd("source " .. base .. "/themes/ThemerDefault.vim")

-- hide tildes at end of buffers
vim.cmd([[ set fillchars=eob:\ ]])
