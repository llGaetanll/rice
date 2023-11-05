local util = require("al.ui.highlights.util")

return function(colors)
	-- since our theme doesn't get darker than bg0,
	-- we need to make the color even darker

	-- number taken from bufferline source
	local window_shading = -45
	local nvim_tree_bg = util.shade_color(colors.bg0, window_shading)

	return {
		-- hide NvimTree's window separator
		-- set both fg and bg
		NvimTreeWinSeparator = {
			fg = colors.bg0,
			bg = colors.bg0,
		},

		-- set NvimTree's background color
		NvimTreeNormal = {
			bg = nvim_tree_bg,
		},
		NvimTreeEndOfBuffer = {
			bg = nvim_tree_bg,
		},

		-- NvimTree
		NvimTreeIndentMarker = { fg = colors.bg0 },

		-- this is the title above NvimTree
		-- this actually belongs to BufferLine but is name NvimTreeHeader as this is
		-- more appropriate
		NvimTreeHeader = {
			fg = colors.blue,
			bg = nvim_tree_bg,
			bold = true,
			italic = true,
		},
	}
end
