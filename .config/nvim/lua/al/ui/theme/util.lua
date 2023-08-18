-- Get colors of a highlight group by name
-- @param name Name of highlight group
local function get_hl(name)
	local hl = vim.api.nvim_get_hl_by_name(name, true) --  true to return RGB color

	-- convert to hex
	for k, v in pairs(hl) do
		if type(v) == "number" then
			hl[k] = string.format("#%x", v)
		end
	end

	return hl
end

-- Set all highlight groups. highlight groups are organized as a table
-- @param highlights Table of highlight groups
local function set_highlights(highlights)
	for hl_group, hl in pairs(highlights) do
		vim.api.nvim_set_hl(0, hl_group, hl)
	end
end

return {
	get_hl = get_hl,
	set_highlights = set_highlights,

	-- these icons are used across nvim for lsp, nvim-tree, bufferline, etc...
	lsp_icons = {
		error = "󰅙",
		warn = "",
		hint = "󰌵",
		info = "",
	},
}
