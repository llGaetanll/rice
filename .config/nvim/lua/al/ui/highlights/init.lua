local util = require "al.ui.highlights.util"
local get_hl = util.get_hl

local M = {}

-- some highlight fixes aren't worthy of a separate file, so I just put them all
-- here.
local function misc_fixes(colors)
    return {
        Normal = { bg = colors.bg0 },
        NormalFloat = { bg = colors.bg0, fg = colors.bg3 },

        -- set SignColumn bg to be transparent
        SignColumn = { bg = "NONE" },

        -- GitSigns
        GitSignsAdd = { fg = colors.green, bg = "NONE" },
        GitSignsChange = { fg = colors.blue, bg = "NONE" },
        GitSignsDelete = { fg = colors.red, bg = "NONE" },

        -- LSP
        DiagnosticSignInfo = { fg = colors.blue, bg = "NONE" },
        DiagnosticSignWarn = { fg = colors.yellow, bg = "NONE" },
        DiagnosticSignHint = { fg = colors.aqua, bg = "NONE" },
        DiagnosticSignError = { fg = colors.red, bg = "NONE" },

        -- WhichKey
        WhichKeyFloat = { bg = colors.bg1 },
    }
end

-- get main colors
-- TODO: this comes from Gruvbox. generalize
local colors = {
    -- darks
    bg0 = get_hl("GruvboxBg0").foreground,
    bg1 = get_hl("GruvboxBg1").foreground,
    bg2 = get_hl("GruvboxBg2").foreground,
    bg3 = get_hl("GruvboxBg3").foreground,
    bg4 = get_hl("GruvboxBg4").foreground,

    -- lights
    fg0 = get_hl("GruvboxFg0").foreground,
    fg1 = get_hl("GruvboxFg1").foreground,
    fg2 = get_hl("GruvboxFg2").foreground,
    fg3 = get_hl("GruvboxFg3").foreground,
    fg4 = get_hl("GruvboxFg4").foreground,

    -- accent colors
    red = get_hl("GruvboxRed").foreground,
    aqua = get_hl("GruvboxAqua").foreground,
    blue = get_hl("GruvboxBlue").foreground,
    gray = get_hl("GruvboxGray").foreground,
    green = get_hl("GruvboxGreen").foreground,
    orange = get_hl("GruvboxOrange").foreground,
    purple = get_hl("GruvboxPurple").foreground,
    yellow = get_hl("GruvboxYellow").foreground,
}

local fixes = { "cmp", "nvim-tree", "telescope", "dressing" }
local groups = util.merge_groups(fixes, colors)

-- add miscelanious
local misc_groups = misc_fixes(colors)
groups = vim.tbl_deep_extend("force", groups, misc_groups)

util.set_highlights(groups)

return M
