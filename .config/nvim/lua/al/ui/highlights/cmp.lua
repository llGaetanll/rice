return function(colors)
	return {
		-- Nvim.cmp
		-- PmenuSel = { bg = hl_normal_float.background, fg = hl_win_separator.foreground },
		-- Pmenu = { bg = normal.background, fg = hl_win_separator.foreground },
		PmenuSel = { bg = colors.bg2, fg = colors.bg3 },
		Pmenu = { bg = colors.bg0, fg = colors.bg3 },

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
end
