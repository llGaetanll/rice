local util = require "al.ui.highlights.util"

return function(colors)
    -- since our theme doesn't get darker than bg0,
    -- we need to make the color even darker

    -- number taken from bufferline source
    local window_shading = -45
    local nvim_tree_bg = util.shade_color(colors.bg0, window_shading)

    return {
        -- These highlights are actually created in the dressing config and don't
        -- bleed over to any other plugin
        DressingFloatBorder = {
            bg = nvim_tree_bg,
            fg = colors.bg4,
        },

        DressingFloatTitle = {
            bg = nvim_tree_bg,
            fg = colors.blue,
        },

        DressingInputText = {
            bg = nvim_tree_bg,
            fg = colors.bg5,
        },
    }
end
