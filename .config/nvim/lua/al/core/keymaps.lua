-- this file contains general keymappins in neovim
-- for LSP keymaps, see lsp/mason.lua

-- whichkey config params
local which_key_config = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},

		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},

	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = {
		gc = "Comments",
	},

	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},

	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},

	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},

	window = {
		border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},

	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},

	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label

	hidden = { -- hide mapping boilerplate
		"<silent>",
		"<cmd>",
		"<Cmd>",
		"<CR>",
		"call",
		"lua",
		"^:",
		"^ ",
	},

	show_help = true, -- show help message on the command line when the popup is visible

	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"}                -- or specify a list manually

	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},

	-- disable the WhichKey popup for certain buf types and file types.
	-- Disabled by deafult for Telescope
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
}

-- setup whichkey, if installed
local status_ok, whichkey = pcall(require, "which-key")
if status_ok then
	whichkey.setup(which_key_config)
end

local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

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
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
--
-- -- Telescope Keybinds
-- local telescope_ok, telescope_builtin = pcall(require, 'telescope.builtin')
-- if telescope_ok then
--   vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
--   vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
--   vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
--   vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
-- end

local telescope_keybinds = {
	{
		mode = "n",
		keymap = "<leader>ff",
		action = require("telescope.builtin").find_files,
		desc = "[f]ind [f]iles",
	},
	{
		mode = "n",
		keymap = "<leader>fg",
		action = require("telescope.builtin").live_grep,
		desc = "[f]ile [g]rep",
	},
	{
		mode = "n",
		keymap = "<leader>fb",
		action = require("telescope.builtin").buffers,
		desc = "[f]ind [b]uffers",
	},
	{
		mode = "n",
		keymap = "<leader>fh",
		action = require("telescope.builtin").help_tags,
		desc = "[f]ind [h]elp",
	},
	{
		mode = "n",
		keymap = "<leader>gh",
		action = require("telescope.builtin").highlights,
		desc = "[g]et [h]ighlights",
	},
	{
		mode = "n",
		keymap = "<leader>kb",
		action = require("telescope.builtin").keymaps,
		desc = "[k]ey [b]indings",
	},
}

-- Telescope Keybinds
for _, km in ipairs(telescope_keybinds) do
	vim.keymap.set(km.mode, km.keymap, km.action, { desc = km.desc })
end

local keybinds = {
	{
		mode = "n",
		keymap = "<leader><Space>",
		action = "<cmd>WhichKey<CR>",
		desc = "List all keybinds",
	},

	-- resize panes
	{
		mode = "n",
		keymap = "<C-Up>",
		action = "<cmd>resize -2<CR>",
		desc = "Resize windows",
	},
	{
		mode = "n",
		keymap = "<C-Down>",
		action = "<cmd>resize +2<CR>",
		desc = "Resize windows",
	},
	{
		mode = "n",
		keymap = "<C-Left>",
		action = "<cmd>vertical resize -2<CR>",
		desc = "Resize windows",
	},
	{
		mode = "n",
		keymap = "<C-Right>",
		action = "<cmd>vertical resize +2<CR>",
		desc = "Resize windows",
	},

	-- Navigate Panes
	{
		mode = "n",
		keymap = "<Up>",
		action = "<C-w>k",
		desc = "Navigate to window above",
	},
	{
		mode = "n",
		keymap = "<Down>",
		action = "<C-w>j",
		desc = "Navigate to window below",
	},
	{
		mode = "n",
		keymap = "<Left>",
		action = "<C-w>h",
		desc = "Navigate to left window",
	},
	{
		mode = "n",
		keymap = "<Right>",
		action = "<C-w>l",
		desc = "Navigate to right window",
	},

	-- Move Panes
	{
		mode = "n",
		keymap = "<S-Up>",
		action = "<C-w>K",
		desc = "Move window above",
	},
	{
		mode = "n",
		keymap = "<S-Down>",
		action = "<C-w>J",
		desc = "Move window below",
	},
	{
		mode = "n",
		keymap = "<S-Left>",
		action = "<C-w>H",
		desc = "Move window left",
	},
	{
		mode = "n",
		keymap = "<S-Right>",
		action = "<C-w>L",
		desc = "Move window right",
	},

	-- Navigate Tabs
	{
		mode = "n",
		keymap = "<c-l>",
		action = "gt",
		desc = "next tab",
	},
	{
		mode = "n",
		keymap = "<c-h>",
		action = "gT",
		desc = "prev tab",
	},

	-- Clear search highlighting
	{
		mode = "n",
		keymap = "<Esc>",
		action = ":noh<CR>",
		desc = "clear search highlight",
	},

	-- Stay in visual mode after indenting
	{
		mode = "v",
		keymap = "<",
		action = "<gv",
		desc = "indent less",
	},
	{
		mode = "v",
		keymap = ">",
		action = ">gv",
		desc = "indent more",
	},

	{
		mode = "v", -- visual mode
		keymap = "<c-y>",
		action = '"+y',
		desc = "copy to system clipboard",
	},
	{
		mode = "x", -- visual block
		keymap = "<c-y>",
		action = '"+y',
		desc = "copy to system clipboard",
	},

	{
		mode = "n",
		keymap = "<leader>t",
		action = "<cmd>NvimTreeToggle<CR>",
		desc = "[t]oggle NvimTree",
	},
	{
		mode = "n",
		keymap = "<leader>T",
		action = "<cmd>NvimTreeFocus<CR>",
		desc = "Focus NvimTree",
	},

	-- Markdown
	{
		mode = "n",
		keymap = "<leader>mp",
		action = "<cmd>MarkdownPreview<CR>",
		desc = "Toggle Markdown Preview",
	},

	{
		mode = "n",
		keymap = "<leader>d",
		action = "<C-w>q",
		desc = "Close window",
	},
}

-- set keymaps
for _, km in ipairs(keybinds) do
	keymap(km.mode, km.keymap, km.action, { noremap = true, silent = true, desc = km.desc })
end

-- Navigate tabs
-- keymap("n", "<c-l>", "gT", opts)
-- keymap("n", "<c-h>", "gt", opts)

-- pressing escape clears highlightings
-- keymap("n", "<Esc>", ":noh<CR>", opts)

-- Stay in visual mode after indenting
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- TODO: what is this
-- keymap("v", "p", '"_dP', opts)

-- ctrl + y to copy selection to system clipboard
-- keymap("v", "<c-y>", '"+y', opts) -- visual mode
-- keymap("x", "<c-y>", '"+y', opts) -- visual block

-- NvimTree
-- keymap("n", "<leader>t", ":NvimTreeToggle<CR>", opts)
-- keymap("n", "<leader>T", ":NvimTreeFocus<CR>", opts)
