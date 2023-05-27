local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end


-- load the lsp icons from the theme
local lsp_icons = require('al.ui.theme').lsp_icons

local spaced_icons = {}
for key, value in pairs(lsp_icons) do
  spaced_icons[key] = value .. " "
end


local sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      'diff',
      {
      'diagnostics',
        symbols = spaced_icons,
      }
    },
    lualine_c = {'filename'},
    lualine_x = {'encoding'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }

lualine.setup {
  options = {
    component_separators = { left = ' ', right = ' '},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { "NvimTree", "TelescopePrompt", "packer", "toggleterm" },
    always_divide_middle = false,
  },
  -- sections shown when buffer is focused
  sections = sections,
  -- sections shown when buffer is not focused
  inactive_sections = sections,
}
