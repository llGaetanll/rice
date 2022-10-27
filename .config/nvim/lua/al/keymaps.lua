-- this file contains general keymappins in neovim
-- for LSP keymaps, see lsp/mason.lua

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- LEADER KEY: <Space>
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- needed for VimTeX

-- Modes (first param of keymaps)
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation (ctrl + hjkl to move around buffers instead of (ctrl + w) + hjkl)
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- scroll screen left and right TODO: find better ones
-- keymap("n", "<C-d>", "zh", opts)
-- keymap("n", "<C-g>", "zl", opts)

-- Resize windows with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate tabs
keymap("n", "<c-l>", "gT", opts)
keymap("n", "<c-h>", "gt", opts)

-- pressing escape clears highlightings
keymap("n", "<Esc>", ":noh<CR>", opts)

-- Move text up and down (clashes with st)
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)


-- Stay in visual mode after indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- TODO: what is this
keymap("v", "p", '"_dP', opts)

-- ctrl + y to copy selection to system clipboard
keymap("v", "<c-y>", '"+y', opts) -- visual mode
keymap("x", "<c-y>", '"+y', opts) -- visual block

-- Move text up and down in visual block
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- NvimTree
keymap("n", "<leader>t", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>T", ":NvimTreeFocus<CR>", opts)
