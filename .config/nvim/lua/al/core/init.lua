require "al.core.options" -- load profile options
require "al.core.keymaps" -- load keymaps

require "al.core.git"     -- load git plugins

require "al.core.comment" -- load commenting plugins

local util = require "al.util"
util.lazy_require "al.core.completion" -- load completion plugins (LSP, Snippets, Autopairs)

-- FIXME: Move this to Telescope opts
require "al.core.search" -- load search plugins
