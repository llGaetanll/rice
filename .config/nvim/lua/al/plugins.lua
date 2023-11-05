local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Have packer manage itself
	-- 	this is the package manager
	use("wbthomason/packer.nvim")

	--[[ 	Colorschemes ]]
	-- for more TreeSitter colorschemes
	-- see: https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
	use("savq/melange")
	use("mhartington/oceanic-next")
	use("kyazdani42/blue-moon")
	use("sainnhe/everforest")
	use("martinsione/darkplus.nvim")
	use("ellisonleao/gruvbox.nvim")

	use({ "llGaetanll/prisma.nvim", branch = "dev" })

	--[[ 	TreeSitter ]]
	-- parses the file much more accurately to provide better commenting / syntax-highlighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("hiphish/rainbow-delimiters.nvim")
	-- use("nvim-treesitter/playground")

	--[[ Commenting ]]
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("JoosepAlviste/nvim-ts-context-commentstring") -- for native jsx context-aware commenting

	use("lukas-reineke/indent-blankline.nvim") -- display indents

	--[[ CMP - Autocomplete ]]
	-- This is actually necessary for lsp to work
	use("hrsh7th/nvim-cmp") -- base
	use("hrsh7th/cmp-nvim-lsp") -- autocompletion from nvim lsp
	use("hrsh7th/cmp-buffer") -- autocompletion from buffers
	use("hrsh7th/cmp-path") -- autocompletion for paths
	use("hrsh7th/cmp-cmdline") -- autocompletion for nvim commands

	--[[ Snippets ]]
	use("L3MON4D3/LuaSnip") -- snippets used in autocompletion
	use("saadparwaiz1/cmp_luasnip") -- luasnip completion source for nvim-cmp
	use("rafamadriz/friendly-snippets") -- massive repo of popular snippets for autocompletion

	--[[ Autopairs ]]
	use("windwp/nvim-autopairs") -- autocomplete parentheses, brackets, etc...

	--[[ File Formatting ]]
	use("mhartington/formatter.nvim") -- automatically format files on save

	--[[ Telescope ]]
	-- fuzzy-finding
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- telescope for snippets
	use({
		"benfowler/telescope-luasnip.nvim",
		module = "telescope._extensions.luasnip", -- if you wish to lazy-load
	})

	--[[ LSP - Language Server Protocol ]]
	use({
		"williamboman/mason.nvim", -- simple to use language server installer
		"williamboman/mason-lspconfig.nvim", -- allows interop between mason and lsconfig
		"neovim/nvim-lspconfig", -- enable lsp
	})

	--[[ GIT ]]
	use("lewis6991/gitsigns.nvim") -- git indicators
	use("sindrets/diffview.nvim") -- git diff integration

	--[[ GPT autocompletion ]]
	use("github/copilot.vim") -- github copilot in nvim

	--[[ OTHER ]]
	use("folke/which-key.nvim") -- tells you all your keybinds
	use("akinsho/bufferline.nvim") -- pseudo "tabs" to work with nvim tree
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	}) -- airline for lua
	use("kyazdani42/nvim-tree.lua") -- filesystem tree
	use("kyazdani42/nvim-web-devicons") -- icons for nvim tree
	use("norcalli/nvim-colorizer.lua") -- colorize CSS color codes
	use("onsails/lspkind.nvim") -- nvim cmp icons
	use("stevearc/dressing.nvim") -- improved UI interfaces

	--[[ Language Specific ]]
	use("lervag/vimtex") -- latex support

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	}) -- markdown preview

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
