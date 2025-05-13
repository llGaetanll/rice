return function(colors)
    return {
        LualineBreadcrumbDir = { fg = colors.fg0, bg = colors.bg1 },
        LualineBreadcrumbFile = { fg = colors.fg3, bg = colors.bg1 },
        LualineBreadcrumbConnector = { fg = colors.bg3, bg = colors.bg1 },

        LualineDiffAdd = { fg = colors.green, bg = colors.bg2 },
        LualineDiffChange = { fg = colors.orange, bg = colors.bg2 },
        LualineDiffDelete = { fg = colors.red, bg = colors.bg2 },

        LualineDiagnosticError = { fg = colors.red, bg = colors.bg2 },
        LualineDiagnosticWarn = { fg = colors.yellow, bg = colors.bg2 },
        LualineDiagnosticInfo = { fg = colors.blue, bg = colors.bg2 },
        LualineDiagnosticHint = { fg = colors.cyan, bg = colors.bg2 },
    }
end
