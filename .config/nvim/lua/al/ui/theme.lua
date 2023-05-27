-- set colorscheme here
local colorscheme = "gruvbox"

-- set the color scheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end



-- hide tildes at end of buffers
vim.cmd [[ set fillchars=eob:\ ]]



-- Get colors of a highlight group by name
-- @param name Name of highlight group
local function get_hl(name)
  local hl = vim.api.nvim_get_hl_by_name(name, true) --  true to return RGB color

  -- convert to hex
  for k, v in pairs(hl) do
    if type(v) == "number" then
      hl[k] = string.format("#%x", v)
    end
  end

  return hl
end


-- Set all highlight groups. highlight groups are organized as a table
-- @param highlights Table of highlight groups
local function set_highlights(highlights)
  for hl_group, hl in pairs(highlights) do
    -- build string
    local cmd_str = "hi " .. hl_group

    -- if the fg field exists
    if type(hl.fg) ~= "nil" then
    cmd_str = cmd_str .. " guifg=" .. hl.fg
    end

    -- if the bg field exists
    if type(hl.bg) ~= "nil" then
    cmd_str = cmd_str .. " guibg=" .. hl.bg
    end

    local guiopts = {}
    -- if bold is set
    if hl.bold and hl.bold == true then
    table.insert(guiopts, "bold")
    end

    -- if italics is set
    if hl.italic and hl.italic == true then
    table.insert(guiopts, "italic")
    end

    -- if some gui option is set
    if next(guiopts) ~= nil then
    cmd_str = cmd_str .. " gui=" .. table.concat(guiopts, ",")
    end

    -- set highlight group
    vim.cmd(cmd_str)
  end
end


-- TODO: define proper color scheme. This is a temp solution
local hl_normal = get_hl("Normal") -- dark
local hl_normal_float = get_hl("NormalFloat") -- lighter
local hl_conceal = get_hl("Conceal") -- light gray text

local darker = "#1e1e1e"
local dark = get_hl("TabLine").background
local normal = hl_normal.background
local lighter = hl_normal_float.background

-- accent colors
local accent1 = get_hl("Directory").foreground
local accent2 = get_hl("Title").foreground
local accent3 = get_hl("ModeMsg").foreground


local hl_win_separator = get_hl("WinSeparator")

-- use `:hi` to see all highlight groups
local highlights = {
  -- hide NvimTree's window separator
  -- set both fg and bg
  NvimTreeWinSeparator = {
    fg = normal,
    bg = normal
  },

  -- set NvimTree's background color
  -- TODO: make darker
  NvimTreeNormal = {
    bg = darker -- hl_normal_float.background
  },
  NvimTreeEndOfBuffer = {
    bg = darker -- hl_normal_float.background
  },

  -- [[ SignColumn ]] --

  -- set SignColumn bg to be transparent
  SignColumn = { bg = "NONE" },

  -- GitSigns
  GitSignsAdd = { fg = get_hl("GitSignsAdd").foreground, bg = "NONE" },
  GitSignsChange = { fg = get_hl("GitSignsChange").foreground, bg = "NONE" },
  GitSignsDelete = { fg = get_hl("GitSignsDelete").foreground, bg = "NONE" },

  -- LSP
  DiagnosticSignInfo = { fg = get_hl("DiagnosticSignInfo").foreground, bg = "NONE" },
  DiagnosticSignWarn = { fg = get_hl("DiagnosticSignWarn").foreground, bg = "NONE" },
  DiagnosticSignHint = { fg = get_hl("DiagnosticSignHint").foreground, bg = "NONE" },
  DiagnosticSignError = { fg = get_hl("DiagnosticSignError").foreground, bg = "NONE" },

  -- NvimTree
  NvimTreeIndentMarker = { fg = hl_win_separator.foreground },

  -- this is the title above NvimTree
  -- this actually belongs to BufferLine but is name NvimTreeHeader as this is
  -- more appropriate
  NvimTreeHeader = {
    fg = accent1,
    bg = darker,
    bold = true,
    italic = true
  },

  -- Telescope
  TelescopeBorder = { fg = darker, bg = darker },

  TelescopeNormal = { bg = darker },

  -- top left
  TelescopePromptBorder = { fg = lighter, bg = lighter },
  TelescopePromptNormal = { fg = accent1, bg = lighter },
  TelescopePromptPrefix = { fg = accent1, bg = lighter, bold = true },
  TelescopePromptTitle = { fg = darker, bg = accent1, bold = true },
  TelescopePromptCounter = { fg = hl_conceal.foreground, bg = lighter },

  -- bottom left
  TelescopeResultsTitle = { fg = dark , bg = accent3, bold = true },
  TelescopeResultsBorder = { fg = dark, bg = dark },
  TelescopeResultsNormal = { bg = dark },

  -- right
  TelescopePreviewTitle = { fg = darker, bg = accent2, bold = true },
  TelescopePreviewBorder = { fg = darker, bg = darker },

  TelescopeSelection = { bg = normal },
}

-- fg_bg("TelescopeBorder", darker_black, darker_black)
-- fg_bg("TelescopePromptBorder", black2, black2)
--
-- fg_bg("TelescopePromptNormal", white, black2)
-- fg_bg("TelescopePromptPrefix", red, black2)
--
-- bg("TelescopeNormal", darker_black)
--
-- fg_bg("TelescopePreviewTitle", black, green)
-- fg_bg("TelescopePromptTitle", black, red)
-- fg_bg("TelescopeResultsTitle", darker_black, darker_black)
--
-- bg("TelescopeSelection", black2)


local M = {}

-- this icons are used across nvim for lsp, nvim-tree, bufferline, etc...
M.lsp_icons = {
  error = "󰅙",
  warn = "",
  hint = "󰌵",
  info = ""
}

-- apply highlight groups
set_highlights(highlights)

return M
