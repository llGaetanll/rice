local M = {}

-- Get colors of a highlight group by name
-- @param name Name of highlight group
function M.get_hl(name)
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
function M.set_highlights(highlights)
  for hl_group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl_group, hl)
  end
end

-- taken from the bufferline source

---Convert a hex color to rgb
---@param color string
---@return number
---@return number
---@return number
local function hex_to_rgb(color)
  local hex = color:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

local function alter(attr, percent)
  return math.floor(attr * (100 + percent) / 100)
end

---@source https://stackoverflow.com/q/5560248
---see: https://stackoverflow.com/a/37797380
---Darken a specified hex color
---@param color string?
---@param percent number
---@return string
function M.shade_color(color, percent)
  if not color then
    return "NONE"
  end
  local r, g, b = hex_to_rgb(color)
  if not r or not g or not b then
    return "NONE"
  end
  r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
  r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
  return ("#%02x%02x%02x"):format(r, g, b)
end

function M.merge_groups(fixes, colors)
  local groups = {}

  local path = "al.ui.highlights."

  for _, file in ipairs(fixes) do
    local ok, get_groups = pcall(require, path .. file)

    if ok then
      local local_groups = get_groups(colors)
      groups = vim.tbl_deep_extend("force", groups, local_groups)
    end
  end

  return groups
end

return M
