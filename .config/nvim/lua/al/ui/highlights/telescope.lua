local util = require "al.ui.highlights.util"

return function(colors)
    local base_color = colors.bg0

    local dark = util.shade_color(base_color, -10)
    local darker = util.shade_color(base_color, -25)
    local darkest = util.shade_color(base_color, -35)

    return {
        -- Telescope
        TelescopeBorder = { fg = colors.darker, bg = colors.darker },

        TelescopeNormal = { bg = colors.darker },

        -- top left
        TelescopePromptBorder = { fg = dark, bg = dark },
        TelescopePromptNormal = { fg = colors.fg0, bg = dark },
        TelescopePromptPrefix = { fg = colors.fg0, bg = dark, bold = true },
        TelescopePromptTitle = { fg = dark, bg = colors.blue, bold = true },
        TelescopePromptCounter = { fg = colors.fg3, bg = dark },

        -- bottom left
        TelescopeResultsTitle = { fg = darker, bg = colors.green, bold = true },
        TelescopeResultsBorder = { fg = darker, bg = darker },
        TelescopeResultsNormal = { bg = darker },
        TelescopeSelection = { bg = base_color },

        -- right
        TelescopePreviewTitle = { fg = darkest, bg = colors.purple, bold = true },
        TelescopePreviewBorder = { fg = darkest, bg = darkest },
        TelescopePreviewNormal = { bg = darkest },
    }
end
