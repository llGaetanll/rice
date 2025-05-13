local util = require "al.ui.highlights.util"

-- We also set more highlights in the lualine config file
local fixes = { "misc", "cmp", "nvim-tree", "telescope", "dressing", "lualine" }
local colors = util.gen_colors()
local groups = util.merge_groups(fixes, colors)

util.set_highlights(groups)
