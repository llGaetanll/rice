local util = require "al.ui.highlights.util"
local get_hl = util.get_hl

-- get main colors
local colors = {
  -- darks
  bg0 = get_hl("Base00Bg").bg,
  bg1 = get_hl("Base01Bg").bg,
  bg2 = get_hl("Base02Bg").bg,
  bg3 = get_hl("Base03Bg").bg,

  -- lights
  fg0 = get_hl("Base04Bg").bg,
  fg1 = get_hl("Base05Bg").bg,
  fg2 = get_hl("Base06Bg").bg,
  fg3 = get_hl("Base07Bg").bg,

  -- accent colors
  red = get_hl("Base08Bg").bg,
  orange = get_hl("Base09Bg").bg,
  yellow = get_hl("Base0ABg").bg,
  green = get_hl("Base0BBg").bg,
  cyan = get_hl("Base0CBg").bg,
  blue = get_hl("Base0DBg").bg,
  purple = get_hl("Base0EBg").bg,
  gray = get_hl("Base0FBg").bg,
}

local fixes = { "misc", "cmp", "nvim-tree", "telescope", "dressing", "lualine" }
local groups = util.merge_groups(fixes, colors)

util.set_highlights(groups)
