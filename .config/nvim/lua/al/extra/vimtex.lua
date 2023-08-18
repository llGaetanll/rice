--[[ local status_ok, _ = pcall(require, "vimtex")
if not status_ok then
	return
end ]]

vim.cmd([[ syntax enable ]])

-- Error Suppression
-- https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt
vim.g.vimtex_log_ignore = { "Underfull", "Overfull" }
vim.g.vimtex_view_method = "zathura"

-- vim.g.vimtex_compiler_method = "latex-mk"
