require "al.core.options" -- load profile options
local util = require "al.util"

-- TODO: Keymaps could be more efficient. Split into core keymaps and plugin
-- keymaps (in extra)
util.lazy_require "al.core.keymaps" -- load keymaps
util.lazy_require "al.core.completion" -- load completion plugins (LSP, Snippets, Autopairs)
