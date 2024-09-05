return function(colors)
  return {
    -- Normal = { bg = colors.bg0 },
    NormalFloat = { bg = colors.bg1 },
    WinSeparator = { fg = colors.bg3, bg = colors.bg0 },

    -- set SignColumn bg to be transparent
    SignColumn = { bg = "NONE" },

    -- GitSigns
    GitSignsAdd = { fg = colors.green, bg = "NONE" },
    GitSignsChange = { fg = colors.orange, bg = "NONE" },
    GitSignsDelete = { fg = colors.red, bg = "NONE" },

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

    -- TreeSitter
    TSVariable = { link = "Base06Fg" },
    TSVariableBuiltin = { link = "Base06Fg" },
    Identifier = { link = "Base0DFg" },
    TSProperty = { link = "Base0DFg" },
    TSInclude = { link = "TSKeyword" },
    TSNamespace = { link = "Base09Fg" },
    Operator = { link = "Base09Fg" },

    -- rust
    ['@lsp.type.macro.rust'] = { link = "Base0CFg" },
    ['@lsp.type.property.rust'] = { link = "Base04Fg" },
    ['@lsp.type.selfKeyword.rust'] = { link = "Base09Fg" }
  }
end
