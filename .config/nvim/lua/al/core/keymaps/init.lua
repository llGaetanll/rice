local global = require("al.core.keymaps.global")
local telescope = require("al.core.keymaps.telescope")

local keymap = vim.api.nvim_set_keymap

-- LEADER KEY: <Space>
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- needed for VimTeX

-- set keymaps
for _, km in ipairs(global) do
	keymap(km.mode, km.keymap, km.action, { noremap = true, silent = true, desc = km.desc })
end

-- Telescope Keybinds
for _, km in ipairs(telescope) do
	vim.keymap.set(km.mode, km.keymap, km.action, { desc = km.desc })
end
