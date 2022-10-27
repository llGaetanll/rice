require "al.plugins" 		  -- load all the plugins
require "al.colorscheme" 	-- load the default colorscheme

-- GENERAL KEY MAPPINGS
require "al.keymaps" 		

-- TREESITTER
require "al.treesitter" 		

-- COMMENTS
require "al.options" 		
require "al.comment" 		

-- Tabs
require "al.bufferline" 		

-- NvimTree - Side window
require "al.nvim-tree"

-- Git configuration
require "al.gitsigns"

-- Lualine - Bottom line
require "al.lualine"

-- Autocomplete
require "al.cmp"         -- cmp.nvim configuration
require "al.autopairs"   -- auto complete any parentheses, brackets, etc...

-- LSP
require "al.lsp"
