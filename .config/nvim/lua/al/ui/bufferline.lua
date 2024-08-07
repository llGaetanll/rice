local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	-- for a list of options, see :h bufferline-configuration
	options = {
		-- use as tabs instead of buffers
		mode = "tabs",

		numbers = "none",
		close_command = "q %d",
		right_mouse_command = "q %d",

		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator_icon = nil,
		indicator = {
			-- style = "icon",
			style = "none",
			-- icon = "▎"
		},

		show_tab_indicators = false,
		show_buffer_icons = true,
		show_close_icon = false,
		show_buffer_close_icons = false,

		modified_icon = "●",

		left_trunc_marker = "<",
		right_trunc_marker = ">",

		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		tab_size = 21,

		-- diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,

		-- filter out NvimTree from appearing in the tab name
		-- NOTE: this will be called a lot so don't do any heavy processing here
		custom_filter = function(buf_number)
			local buffer_name = vim.fn.bufname(buf_number)

			if not string.find(buffer_name, "NvimTree") then
				return true
			end
		end,

		offsets = {
			{
				filetype = "NvimTree",
				text = "NvimTree",
				highlight = "NvimTreeHeader", -- created in colorscheme.lua
				text_align = "center",
				padding = 0,
			},
		},
		persist_buffer_sort = true,

		-- no separators
		separator_style = { "", "" },

		enforce_regular_tabs = true,
		always_show_bufferline = true,
	},

	highlights = {
		buffer_selected = {
			bold = true,
			italic = false,
		},
		tab_selected = {
			bold = true,
			italic = false,
		},
	},
})
