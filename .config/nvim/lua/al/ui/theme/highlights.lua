local util_ok, util = pcall(require, "al.ui.theme.util")
-- if not util_ok then
-- 	return
-- end

-- TODO: define proper color scheme. This is a temp solution
local hl_normal = util.get_hl("Normal") -- dark
local hl_normal_float = util.get_hl("NormalFloat") -- lighter
local hl_conceal = util.get_hl("Conceal") -- light gray text

local darker = "#1e1e1e"
local dark = util.get_hl("TabLine").background
local normal = hl_normal.background
local lighter = hl_normal_float.background

-- accent colors
local accent1 = util.get_hl("Directory").foreground
local accent2 = util.get_hl("Title").foreground
local accent3 = util.get_hl("ModeMsg").foreground

local hl_win_separator = util.get_hl("WinSeparator")

-- use `:hi` to see all highlight groups
local highlights = {

	NormalFloat = { bg = hl_normal.background },

	-- hide NvimTree's window separator
	-- set both fg and bg
	NvimTreeWinSeparator = {
		fg = normal,
		bg = normal,
	},

	-- set NvimTree's background color
	-- TODO: make darker
	NvimTreeNormal = {
		bg = darker, -- hl_normal_float.background
	},
	NvimTreeEndOfBuffer = {
		bg = darker, -- hl_normal_float.background
	},

	-- [[ SignColumn ]] --

	-- set SignColumn bg to be transparent
	SignColumn = { bg = "NONE" },

	-- GitSigns
	GitSignsAdd = { fg = util.get_hl("GitSignsAdd").foreground, bg = "NONE" },
	GitSignsChange = { fg = util.get_hl("GitSignsChange").foreground, bg = "NONE" },
	GitSignsDelete = { fg = util.get_hl("GitSignsDelete").foreground, bg = "NONE" },

	-- LSP
	DiagnosticSignInfo = { fg = util.get_hl("DiagnosticSignInfo").foreground, bg = "NONE" },
	DiagnosticSignWarn = { fg = util.get_hl("DiagnosticSignWarn").foreground, bg = "NONE" },
	DiagnosticSignHint = { fg = util.get_hl("DiagnosticSignHint").foreground, bg = "NONE" },
	DiagnosticSignError = { fg = util.get_hl("DiagnosticSignError").foreground, bg = "NONE" },

	-- NvimTree
	NvimTreeIndentMarker = { fg = hl_win_separator.foreground },

	-- this is the title above NvimTree
	-- this actually belongs to BufferLine but is name NvimTreeHeader as this is
	-- more appropriate
	NvimTreeHeader = {
		fg = accent1,
		bg = darker,
		bold = true,
		italic = true,
	},

	-- WhichKey
	WhichKeyFloat = { bg = lighter },

	-- Telescope
	TelescopeBorder = { fg = darker, bg = darker },

	TelescopeNormal = { bg = darker },

	-- top left
	TelescopePromptBorder = { fg = lighter, bg = lighter },
	TelescopePromptNormal = { fg = accent1, bg = lighter },
	TelescopePromptPrefix = { fg = accent1, bg = lighter, bold = true },
	TelescopePromptTitle = { fg = darker, bg = accent1, bold = true },
	TelescopePromptCounter = { fg = hl_conceal.foreground, bg = lighter },

	-- bottom left
	TelescopeResultsTitle = { fg = dark, bg = accent3, bold = true },
	TelescopeResultsBorder = { fg = dark, bg = dark },
	TelescopeResultsNormal = { bg = dark },

	-- right
	TelescopePreviewTitle = { fg = darker, bg = accent2, bold = true },
	TelescopePreviewBorder = { fg = darker, bg = darker },

	TelescopeSelection = { bg = normal },

	-- Nvim.cmp
	PmenuSel = { bg = hl_normal_float.background, fg = hl_win_separator.foreground },
	Pmenu = { bg = normal.background, fg = hl_win_separator.foreground },

	CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
	CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
	CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
	CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },

	CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
	CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
	CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

	CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
	CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
	CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

	CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
	CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
	CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

	CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
	CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
	CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
	CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
	CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

	CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
	CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

	CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
	CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
	CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

	CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
	CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
	CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

	CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
	CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
	CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
}

-- apply highlight groups
util.set_highlights(highlights)
