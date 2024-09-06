local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

-- load the lsp icons from the theme
local lsp_icons = require("al.ui.styles.util").lsp_icons

local spaced_icons = {}
for key, value in pairs(lsp_icons) do
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
        added    = 'LualineDiffAdd',
        modified = 'LualineDiffChange',
        removed  = 'LualineDiffDelete',
      }
    },
    {
      "diagnostics",
      symbols = spaced_icons,
      diagnostics_color = {
        error = 'LualineDiagnosticError',
        warn  = 'LualineDiagnosticWarn',
        info  = 'LualineDiagnosticInfo',
        hint  = 'LualineDiagnosticHint',
      },
    },
  },
  lualine_c = { filepath },
  lualine_x = { "encoding" },
  lualine_y = { "progress" },
  lualine_z = { "location" },
}

lualine.setup {
  options = {
    component_separators = { left = " ", right = " " },
    section_separators = { left = "", right = "" },
    -- disabled_filetypes = { "NvimTree", "TelescopePrompt", "packer", "toggleterm" },
    always_divide_middle = false,
  },
  -- sections shown when buffer is focused
  sections = sections,
  -- sections shown when buffer is not focused
  inactive_sections = sections,
}
