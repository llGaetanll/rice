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

    -- Which query to use for finding delimiters
    query = {
      'rainbow-parens',
      html = 'rainbow-tags',
      latex = 'rainbow-blocks', -- doesn't work. maybe vimtex overrides?
      javascript = 'rainbow-tags-react',
    },

    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  }
}

-- config treesitter if installed
local ts_ok, configs = pcall(require, "nvim-treesitter.configs")
if ts_ok then
	configs.setup(ts_config)
end

-- config colorizer if installed
local colorizer_ok, colorizer = pcall(require, "colorizer")
if colorizer_ok then
	colorizer.setup()
end
