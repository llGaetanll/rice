-- this file contains all git help plugins
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_ok then
	return
end

gitsigns.setup()

local diffview_ok, diffview = pcall(require, "diffview")
if not diffview_ok then
	return
end

diffview.setup({
	enhanced_diff_hl = true,
})
