local M = {}

local clamp = function(val, lo, hi)
  if val < lo then
    return lo
  end

  if val > hi then
    return hi
  end

  return val
end

-- Get colors of a highlight group by name
-- @param name Name of highlight group
function M.get_hl(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })

  -- convert to hex
  for k, v in pairs(hl) do
    if type(v) == "number" then
      hl[k] = string.format("#%06x", v)
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

---@param color string
---@return number r Float `[0, 1]`
---@return number g Float `[0, 1]`
---@return number b Float `[0, 1]`
local function hex_to_rgb(color)
  local hex = color:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16) / 0xff, tonumber(hex:sub(3, 4), 16) / 0xff, tonumber(hex:sub(5), 16) / 0xff
end

---@param r number Float `[0, 1]`
---@param g number Float `[0, 1]`
---@param b number Float `[0, 1]`
---@return string
local function rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r * 0xff, g * 0xff, b * 0xff)
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
  r, g, b = r * 0xff, g * 0xff, b * 0xff
  if not r or not g or not b then
    return "NONE"
  end
  r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
  r, g, b = math.min(r, 0xff), math.min(g, 0xff), math.min(b, 0xff)
  return ("#%02x%02x%02x"):format(r, g, b)
end

---@param h number Hue. Float [0,360)
---@param s number Saturation. Float [0,1]
---@param v number Value. Float [0,1]
---@return number r Float `[0, 1]`
---@return number g Float `[0, 1]`
---@return number b Float `[0, 1]`
local hsv_to_rgb = function(h, s, v)
  h = h % 360
  s = clamp(s, 0, 1)
  v = clamp(v, 0, 1)

  local function f(n)
    local k = (n + h / 60) % 6
    return v - v * s * math.max(math.min(k, 4 - k, 1), 0)
  end

  return f(5), f(3), f(1)
end

---@param r number Float `[0, 1]`
---@param g number Float `[0, 1]`
---@param b number Float `[0, 1]`
---@return number h Hue. Float `[0, 360)`
---@return number s Saturation. Float `[0, 1]`
---@return number v Value. Float `[0, 1]`
local rgb_to_hsv = function(r, g, b)
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local delta = max - min
  local h = 0
  local s = 0
  local v = max

  if max == min then
    h = 0
  elseif max == r then
    h = 60 * ((g - b) / delta)
  elseif max == g then
    h = 60 * ((b - r) / delta + 2)
  elseif max == b then
    h = 60 * ((r - g) / delta + 4)
  end

  if h < 0 then
    h = h + 360
  end
  if max ~= 0 then
    s = (max - min) / max
  end

  return h, s, v
end

---@param color string
---@return number h Hue. Float `[0, 360)`
---@return number s Saturation. Float `[0, 1]`
---@return number v Value. Float `[0, 1]`
local hex_to_hsv = function(color)
  local r, g, b = hex_to_rgb(color)
  return rgb_to_hsv(r, g, b)
end

---@param h number Hue. Float [0,360)
---@param s number Saturation. Float [0,1]
---@param v number Value. Float [0,1]
---@return string
local hsv_to_hex = function(h, s, v)
  local r, g, b = hsv_to_rgb(h, s, v)
  return rgb_to_hex(r, g, b)
end

---@param h number Hue. Float `[0, 360)`
---@param s number Saturation. Float `[0, 1]`
---@param l number Lightness. Float `[0, 1]`
---@return number r Float `[0, 1]`
---@return number g Float `[0, 1]`
---@return number b Float `[0, 1]`
local hsl_to_rgb = function(h, s, l)
  h = h % 360
  s = clamp(s, 0, 1)
  l = clamp(l, 0, 1)
  local _a = s * math.min(l, 1 - l)

  local function f(n)
    local k = (n + h / 30) % 12
    return l - _a * math.max(math.min(k - 3, 9 - k, 1), -1)
  end

  return f(0), f(8), f(4)
end

---@param r number Float `[0, 1]`
---@param g number Float `[0, 1]`
---@param b number Float `[0, 1]`
---@return number h Hue. Float `[0, 360)`
---@return number s Saturation. Float `[0, 1]`
---@return number l Lightness. Float `[0, 1]`
local rgb_to_hsl = function(r, g, b)
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local delta = max - min
  local h = 0
  local s = 0
  local l = (max + min) / 2

  if max == min then
    h = 0
  elseif max == r then
    h = 60 * ((g - b) / delta)
  elseif max == g then
    h = 60 * ((b - r) / delta + 2)
  elseif max == b then
    h = 60 * ((r - g) / delta + 4)
  end

  if h < 0 then
    h = h + 360
  end
  if max ~= 0 and min ~= 1 then
    s = (max - l) / math.min(l, 1 - l)
  end

  return h, s, l
end


---Modify the lightness of a color
---@param color string Hex color
---@param val number Float [0, 1] Lightness
---@return string Hex
local modify_lightness = function(color, val)
  local r, g, b = hex_to_rgb(color)
  local h, s, l = rgb_to_hsl(r, g, b)
  l = clamp(l + val, 0, 1)

  r, g, b = hsl_to_rgb(h, s, l)
  return rgb_to_hex(r, g, b)
end

---Modify the saturation of a color
---@param color string Hex color
---@param val number Float [0, 1] Saturation
---@return string Hex
local modify_saturation = function(color, val)
  local h, s, v = hex_to_hsv(color)
  s = clamp(s + val, 0, 1)
  return hsv_to_hex(h, s, v)
end

---Modify the value of a color
---@param color string Hex color
---@param val number Float [0, 1] Value
---@return string Hex
local modify_value = function(color, val)
  local h, s, v = hex_to_hsv(color)
  v = clamp(v + val, 0, 1)
  return hsv_to_hex(h, s, v)
end

---Linear interpolation between two points
---@param a number First Number
---@param b number Second Number
---@param d number Delta in [0, 1]
---@return number
local lerp = function(a, b, d)
  return a + d * (b - a)
end

---Blend two hex colors
---@param c1 string Hex color 1
---@param c2 string Hex color 2
---@param p number Number in [0, 1]
---@return string Hex
local blend = function(c1, c2, p)
  local r1, g1, b1 = hex_to_rgb(c1)
  local r2, g2, b2 = hex_to_rgb(c2)

  local r = lerp(r1, r2, p)
  local g = lerp(g1, g2, p)
  local b = lerp(b1, b2, p)

  return rgb_to_hex(r, g, b)
end

function M.to_diff_color(color, background)
  color = blend(color, background, 0.85)
  color = modify_saturation(color, 0.10)

  return color
end

function M.to_diff_color_text(color, background)
  color = blend(color, background, 0.7)
  color = modify_saturation(color, 0.18)
  color = modify_lightness(color, 0.4)

  return color
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
