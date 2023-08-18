require("al.core.options") -- load profile options
require("al.core.keymaps") -- load keymaps

local util = require("al.util")

util.lazy_require("al.core.highlighting") -- load highlighting plugins
util.lazy_require("al.core.git") -- load git plugins

util.lazy_require("al.core.comment") -- load commenting plugins
util.lazy_require("al.core.completion") -- load completion plugins (LSP, Snippets, Autopairs)

util.lazy_require("al.core.search") -- load search plugins
