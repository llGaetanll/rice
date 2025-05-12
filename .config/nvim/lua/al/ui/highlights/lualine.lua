return function(colors)
    return {
        LualineBreadcrumbDir = { fg = colors.fg0, bg = colors.bg1 },
        LualineBreadcrumbFile = { fg = colors.fg3, bg = colors.bg1 },
        LualineBreadcrumbConnector = { fg = colors.bg3, bg = colors.bg1 },

        lualine_a_normal = { fg = colors.bg0, bg = colors.blue },
        lualine_b_normal = { fg = colors.blue, bg = colors.bg2 },
        lualine_c_normal = { fg = colors.fg0, bg = colors.bg1 },

        lualine_a_insert = { fg = colors.bg0, bg = colors.green },
        lualine_b_insert = { fg = colors.green, bg = colors.bg2 },
        lualine_c_insert = { fg = colors.fg0, bg = colors.bg1 },

        lualine_a_visual = { fg = colors.bg0, bg = colors.yellow },
        lualine_b_visual = { fg = colors.yellow, bg = colors.bg2 },
        lualine_c_visual = { fg = colors.fg0, bg = colors.bg1 },

        lualine_a_command = { fg = colors.bg0, bg = colors.red },
        lualine_b_command = { fg = colors.red, bg = colors.bg2 },
        lualine_c_command = { fg = colors.fg0, bg = colors.bg1 },

        LualineDiffAdd = { fg = colors.green, bg = colors.bg2 },
        LualineDiffChange = { fg = colors.orange, bg = colors.bg2 },
        LualineDiffDelete = { fg = colors.red, bg = colors.bg2 },

        LualineDiagnosticError = { fg = colors.red, bg = colors.bg2 },
        LualineDiagnosticWarn = { fg = colors.yellow, bg = colors.bg2 },
        LualineDiagnosticInfo = { fg = colors.blue, bg = colors.bg2 },
        LualineDiagnosticHint = { fg = colors.cyan, bg = colors.bg2 },
    }
end
