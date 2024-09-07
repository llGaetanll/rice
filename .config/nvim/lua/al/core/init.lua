require "al.core.options" -- load profile options
local util = require "al.util"

util.lazy_require "al.core.keymaps"    -- load keymaps
util.lazy_require "al.core.completion" -- load completion plugins (LSP, Snippets, Autopairs)
