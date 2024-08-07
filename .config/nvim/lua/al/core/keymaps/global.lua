return {
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
