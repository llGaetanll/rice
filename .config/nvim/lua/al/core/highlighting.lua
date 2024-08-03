-- This file handles any syntax highlighting which includes treesitter, colorizer, and rainbow parens

-- config treesitter if installed
local ts_ok, configs = pcall(require, "nvim-treesitter.configs")
if ts_ok then
	configs.setup({
		ensure_installed = {}, -- one of "all" or a list of languages
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

-- config colorizer if installed
local colorizer_ok, colorizer = pcall(require, "colorizer")
if colorizer_ok then
	colorizer.setup()
end

-- This module contains a number of default definitions
local raindbow_ok, rainbow_delims = pcall(require, "rainbow-delimiters")
if raindbow_ok then
	vim.g.rainbow_delimiters = {
		strategy = {
			[""] = rainbow_delims.strategy["global"],
			vim = rainbow_delims.strategy["local"],
		},
		query = {
			[""] = "rainbow-delimiters",
			lua = "rainbow-blocks",
		},
		highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		},
	}
end
