-- Load the lsp icons from the theme
local icons = require "al.ui.styles.icons"

local spaced_icons = {}
for key, value in pairs(icons) do
    spaced_icons[key] = value .. " "
end

local breadcrumb_dir_highlight = "%#LualineBreadcrumbDir#"
local breadcrumb_file_highlight = "%#LualineBreadcrumbFile#"
local breadcrumb_connector_highlight = "%#LualineBreadcrumbConnector#"

local function filepath()
    local path = vim.fn.expand "%:~:."
    local parts = vim.split(path, "/", { plain = true })
    local breadcrumbs = {}

    for i, part in ipairs(parts) do
        if i == #parts then
            table.insert(breadcrumbs, breadcrumb_file_highlight .. part)
        else
            table.insert(breadcrumbs, breadcrumb_dir_highlight .. part)
        end
    end

    return table.concat(breadcrumbs, breadcrumb_connector_highlight .. " > ")
end

local sections = {
    lualine_a = { "mode" },
    lualine_b = {
        "branch",
        {
            "diff",
            diff_color = {
                added = "LualineDiffAdd",
                modified = "LualineDiffChange",
                removed = "LualineDiffDelete",
            },
        },
        {
            "diagnostics",
            symbols = spaced_icons,
            diagnostics_color = {
                error = "LualineDiagnosticError",
                warn = "LualineDiagnosticWarn",
                info = "LualineDiagnosticInfo",
                hint = "LualineDiagnosticHint",
            },
        },
    },
    lualine_c = { filepath },
    lualine_x = { "encoding" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
}

return function()
    local util = require "al.ui.highlights.util"
    local colors = util.gen_colors()

    require("lualine").setup({
        options = {
            theme = {
                normal = {
                    a = { fg = colors.bg0, bg = colors.blue },
                    b = { fg = colors.blue, bg = colors.bg2 },
                    c = { fg = colors.fg0, bg = colors.bg1 },
                },
                insert = {
                    a = { fg = colors.bg0, bg = colors.green },
                    b = { fg = colors.green, bg = colors.bg2 },
                    c = { fg = colors.fg0, bg = colors.bg1 },
                },
                visual = {
                    a = { fg = colors.bg0, bg = colors.yellow },
                    b = { fg = colors.yellow, bg = colors.bg2 },
                    c = { fg = colors.fg0, bg = colors.bg1 },
                },
                command = {
                    a = { fg = colors.bg0, bg = colors.red },
                    b = { fg = colors.red, bg = colors.bg2 },
                    c = { fg = colors.fg0, bg = colors.bg1 },
                },
            },
            component_separators = { left = " ", right = " " },
            section_separators = { left = "", right = "" },
            always_divide_middle = false,
        },

        -- sections shown when buffer is focused
        sections = sections,

        -- sections shown when buffer is not focused
        inactive_sections = sections,
    })
end
