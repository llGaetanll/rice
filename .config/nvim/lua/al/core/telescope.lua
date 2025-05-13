-- Search is handled by Telescope
return {
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
        file_ignore_patterns = { "node_modules" },
    },
}
