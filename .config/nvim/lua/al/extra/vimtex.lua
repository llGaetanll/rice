vim.cmd [[ syntax enable ]]

-- Error Suppression
-- See: https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt
vim.g.vimtex_log_ignore = { "Underfull", "Overfull" }
vim.g.vimtex_view_method = "zathura"
