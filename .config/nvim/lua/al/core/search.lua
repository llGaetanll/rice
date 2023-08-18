-- search is handled by telescope

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.setup({
	defaults = {
		selection_caret = " ",
		entry_prefix = " ",
		prompt_prefix = "    ",
		initial_mode = "insert",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {

			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.3,
			},

			vertical = {
				mirror = false,
			},

			-- width and height of telescope
			width = 0.8,
			height = 0.7,

			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
	},
})
