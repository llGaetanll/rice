local util = require "al.ui.highlights.util"

return function(colors)
    return {
        -- Normal = { bg = colors.bg0 },
        NormalFloat = { fg = colors.bg3, bg = colors.bg0 },
        WinSeparator = { fg = colors.bg3, bg = colors.bg0 },

        -- set SignColumn bg to be transparent
        SignColumn = { bg = "NONE" },

        -- GitSigns
        GitSignsAdd = { fg = colors.green, bg = "NONE" },
        GitSignsChange = { fg = colors.orange, bg = "NONE" },
        GitSignsDelete = { fg = colors.red, bg = "NONE" },

        DiffDelete = {
            fg = util.to_diff_color_text(colors.red, colors.bg0),
            bg = util.to_diff_color(colors.red, colors.bg0),
        },
        DiffAdd = {
            fg = util.to_diff_color_text(colors.green, colors.bg0),
            bg = util.to_diff_color(colors.green, colors.bg0),
        },
        DiffChange = {
            fg = util.to_diff_color_text(colors.orange, colors.bg0),
            bg = util.to_diff_color(colors.orange, colors.bg0),
        },
        DiffText = {
            fg = util.to_diff_color_text(colors.yellow, colors.bg0),
            bg = util.to_diff_color(colors.yellow, colors.bg0),
        },

        -- LSP
        DiagnosticInfo = { link = "Base0DFg" },
        DiagnosticHint = { link = "Base0CFg" },
        DiagnosticWarn = { link = "Base0AFg" },
        DiagnosticError = { link = "Base08Fg" },

        DiagnosticUnderlineInfo = { undercurl = true, sp = colors.blue },
        DiagnosticUnderlineHint = { undercurl = true, sp = colors.cyan },
        DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
        DiagnosticUnderlineWarning = { undercurl = true, sp = colors.yellow },
        DiagnosticUnderlineError = { undercurl = true, sp = colors.red },

        -- LSP Hover
        HoverNormal = { link = "Normal" },
        HoverBorder = { link = "WinSeparator" },

        -- TreeSitter
        TSVariable = { link = "Base06Fg" },
        TSVariableBuiltin = { link = "Base06Fg" },
        Identifier = { link = "Base0DFg" },
        TSProperty = { link = "Base0DFg" },
        TSInclude = { link = "TSKeyword" },
        TSField = { link = "Base0DFg" },
        TSFunction = { link = "Base0BFg" },
        TSMethod = { link = "TSFunction" },
        TSNamespace = { link = "Base09Fg" },
        TSFuncMacro = { link = "Base0CFg" },
        Operator = { link = "Base09Fg" },
        TSOperator = { link = "Base09Fg" },

        -- rust
        ["@lsp.type.macro.rust"] = { link = "Base0CFg" },
        ["@lsp.type.property.rust"] = { link = "Base0DFg" },
        ["@lsp.type.selfKeyword.rust"] = { link = "Base09Fg" },
    }
end
