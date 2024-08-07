return {
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
