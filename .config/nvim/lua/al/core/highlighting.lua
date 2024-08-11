-- This file handles any syntax highlighting which includes treesitter, colorizer, and rainbow parens

-- config treesitter if installed
local ts_ok, configs = pcall(require, "nvim-treesitter.configs")
if ts_ok then
	configs.setup({
		ensure_installed = { "rust" }, -- one of "all" or a list of languages
		ignore_install = { "" }, -- List of parsers to ignore installing
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = {
				"css",
				"latex",
			}, -- list of language that will be disabled
		},
		autopairs = {
			enable = true,
		},
		indent = {
			enable = true,
			disable = { "python", "css" },
		},
	})
end
