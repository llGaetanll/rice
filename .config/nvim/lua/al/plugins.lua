-- Bootstrap lazy.nvim
local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(install_path) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(install_path)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup({
  -- plugins here
  spec = {
    { "llGaetanll/prisma.nvim",          branch = "dev" },

    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      opts = {},
      config = function()
        vim.cmd([[colorscheme gruvbox]])
      end
    },

    --[[ TreeSitter ]]
    -- parses the file much more accurately to provide better commenting / syntax-highlighting
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = { "VeryLazy" },
      lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
      init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treesitter** module to be loaded in time.
        -- Luckily, the only things that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
      end,
      cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
      opts = {
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
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
    "hiphish/rainbow-delimiters.nvim",
    "nvim-treesitter/playground",

    --[[ Commenting ]]
    {
      "numToStr/Comment.nvim",
      opts = {}
    },
    "JoosepAlviste/nvim-ts-context-commentstring", -- for native jsx context-aware commenting

    -- display indents
    -- "lukas-reineke/indent-blankline.nvim" -- NOTE: slow for large comment blocks

    --[[ CMP - Autocomplete ]]
    -- This is actually necessary for lsp to work
    "hrsh7th/nvim-cmp",     -- base
    "hrsh7th/cmp-nvim-lsp", -- autocompletion from nvim lsp
    "hrsh7th/cmp-buffer",   -- autocompletion from buffers
    "hrsh7th/cmp-path",     -- autocompletion for paths
    "hrsh7th/cmp-cmdline",  -- autocompletion for nvim commands
    "onsails/lspkind.nvim", -- nvim cmp icons

    --[[ Snippets ]]
    -- snippets used in autocompletion
    {
      "L3MON4D3/LuaSnip",

      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)

      -- massive repo of popular snippets for autocompletion
      dependencies = { "rafamadriz/friendly-snippets" }
    },
    "saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp

    --[[ Autopairs ]]
    "windwp/nvim-autopairs", -- autocomplete parentheses, brackets, etc...

    --[[ File Formatting ]]
    "mhartington/formatter.nvim", -- automatically format files on save

    --[[ Telescope ]]
    -- fuzzy-finding
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = require("al.core.search")
    },

    -- telescope for snippets
    {
      "benfowler/telescope-luasnip.nvim",
      module = "telescope._extensions.luasnip", -- if you wish to lazy-load
    },

    --[[ LSP - Language Server Protocol ]]
    "williamboman/mason.nvim",           -- simple to use language server installer
    "williamboman/mason-lspconfig.nvim", -- allows interop between mason and lsconfig
    "neovim/nvim-lspconfig",             -- enable lsp

    --[[ GIT ]]
    "lewis6991/gitsigns.nvim", -- git indicators
    "sindrets/diffview.nvim",  -- git diff integration

    --[[ GPT autocompletion ]]
    "github/copilot.vim", -- github copilot in nvim

    --[[ OTHER ]]
    { -- tells you all your keybinds
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = require("al.core.keymaps.whichkey")
    },

    -- pseudo "tabs" to work with nvim tree
    "akinsho/bufferline.nvim",

    -- airline for lua
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "kyazdani42/nvim-web-devicons" },
    },

    -- filesystem tree
    {
      "kyazdani42/nvim-tree.lua",
      opts = require("al.ui.nvim-tree")
    },
    "kyazdani42/nvim-web-devicons", -- icons for nvim tree

    -- colorize CSS color codes
    {
      "norcalli/nvim-colorizer.lua",
      opts = {
        '*'
      }
    },
    -- improved UI interfaces
    {
      "stevearc/dressing.nvim",
      opts = {
        input = {
          win_options = {
            -- create new highlight groups that we can use to style dressing
            -- without bleeding over to other plugins
            winhighlight = 'FloatBorder:DressingFloatBorder,FloatTitle:DressingFloatTitle,Normal:DressingInputText'
          },
        }
      }
    },

    --[[ Language Specific ]]
    "lervag/vimtex", -- latex support

    -- markdown preview
    {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    }
  },

  install = { colorscheme = { "gruvbox" } },

  -- automatically check for plugin updates
  checker = { enabled = false },
})
