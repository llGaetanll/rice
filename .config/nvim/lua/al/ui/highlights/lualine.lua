return function (colors)
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
  }
end
