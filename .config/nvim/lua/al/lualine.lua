local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
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
  },
  -- sections shown when buffer is focused
  sections = sections,
  -- sections shown when buffer is not focused
  inactive_sections = sections,
}
