return function(colors)
    return {
        -- Nvim.cmp
        -- PmenuSel = { bg = hl_normal_float.background, fg = hl_win_separator.foreground },
        -- Pmenu = { bg = normal.background, fg = hl_win_separator.foreground },
        PmenuSel = { bg = colors.bg2, fg = colors.bg3 },
        Pmenu = { bg = colors.bg0, fg = colors.bg3 },

        CmpItemAbbrDeprecated = { fg = "#7E8294", strikethrough = true },
        CmpItemAbbrMatch = { fg = "#82AAFF", bold = true },
        CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bold = true },
        CmpItemMenu = { fg = "#C792EA", italic = true },

        CmpItemKindField = { fg = "#EED8DA" },
        CmpItemKindProperty = { fg = "#EED8DA" },
        CmpItemKindEvent = { fg = "#EED8DA" },

        CmpItemKindText = { fg = "#C3E88D" },
        CmpItemKindEnum = { fg = "#C3E88D" },
        CmpItemKindKeyword = { fg = "#C3E88D" },

        CmpItemKindConstant = { fg = "#FFE082" },
        CmpItemKindConstructor = { fg = "#FFE082" },
        CmpItemKindReference = { fg = "#FFE082" },

        CmpItemKindFunction = { fg = "#EADFF0" },
        CmpItemKindStruct = { fg = "#EADFF0" },
        CmpItemKindClass = { fg = "#EADFF0" },
        CmpItemKindModule = { fg = "#EADFF0" },
        CmpItemKindOperator = { fg = "#EADFF0" },

        CmpItemKindVariable = { fg = "#C5CDD9" },
        CmpItemKindFile = { fg = "#C5CDD9" },

        CmpItemKindUnit = { fg = "#F5EBD9" },
        CmpItemKindSnippet = { fg = "#F5EBD9" },
        CmpItemKindFolder = { fg = "#F5EBD9" },

        CmpItemKindMethod = { fg = "#DDE5F5" },
        CmpItemKindValue = { fg = "#DDE5F5" },
        CmpItemKindEnumMember = { fg = "#DDE5F5" },

        CmpItemKindInterface = { fg = "#D8EEEB" },
        CmpItemKindColor = { fg = "#D8EEEB" },
        CmpItemKindTypeParameter = { fg = "#D8EEEB" },
    }
end
