-- This file handles any syntax highlighting which includes treesitter and
-- colorizer

-- treesitter config
local ts_config = {
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css", "latex" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = {
		enable = true,
		disable = { "python", "css" }
	},
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}

-- config treesitter if installed
local ts_ok, configs = pcall(require, "nvim-treesitter.configs")
if ts_ok then
	configs.setup(ts_config)
end

colorizer_config = {}

-- config colorizer if installed
local colorizer_ok, colorizer = pcall(require, "colorizer")
if colorizer_ok then
	colorizer.setup(colorizer_config)
end
