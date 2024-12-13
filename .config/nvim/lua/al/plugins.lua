-- Bootstrap lazy.nvim
local install_path = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(install_path) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    repo,
    install_path,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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

-- We need this set specifically for base16 to work
vim.opt.termguicolors = true

lazy.setup {
  -- plugins here
  spec = {
    { "llGaetanll/prisma.nvim", branch = "dev" },

    -- base16 colorschemes
    {
      "llGaetanll/base16.nvim",
      priority = 1000,
      opts = {
        theme = "default-dark",
      },
    },

    {
      "dstein64/vim-startuptime",
      -- lazy-load on a command
      cmd = "StartupTime",
      -- init is called during startup. Configuration for vim plugins typically should be set in an init function
      init = function()
        vim.g.startuptime_tries = 20
      end,
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
        require "nvim-treesitter.query_predicates"
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

    {
      "hiphish/rainbow-delimiters.nvim",
      event = { "VeryLazy" },
      config = function()
        require("rainbow-delimiters.setup").setup {
          highlight = {
            "RainbowDelimiterOrange",
            "RainbowDelimiterYellow",
            "RainbowDelimiterGreen",
            "RainbowDelimiterCyan",
            "RainbowDelimiterBlue",
            "RainbowDelimiterViolet",
            "RainbowDelimiterRed",
          },
        }
      end,
    },
    {
      "nvim-treesitter/playground",
      event = { "VeryLazy" },
    },

    --[[ Commenting ]]
    {
      "numToStr/Comment.nvim",
      event = { "VeryLazy" },
      config = function()
        require("Comment").setup {
          pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
          toggler = {
            ---Line-comment toggle keymap
            line = "gcc",

            ---Block-comment toggle keymap
            block = "gbc",
          },
        }
      end,
      opts = {},
    },

    -- for native jsx context-aware commenting
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = { "VeryLazy" },
    },

    -- display indents
    {
      "shellRaining/hlchunk.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("hlchunk").setup({
          indent = {
            enable = true,
            style = { vim.api.nvim_get_hl(0, { name = "Base01Fg" }) },
          },
        })
      end
    },

    --[[ CMP - Autocomplete ]]
    -- This is actually necessary for lsp to work
    {
      "hrsh7th/nvim-cmp", -- base
      event = { "VeryLazy" },
    },
    {
      "hrsh7th/cmp-nvim-lsp", -- autocompletion from nvim lsp
      event = { "VeryLazy" },
    },
    {
      "hrsh7th/cmp-buffer", -- autocompletion from buffers
      event = { "VeryLazy" },
    },
    {
      "hrsh7th/cmp-path", -- autocompletion for paths
      event = { "VeryLazy" },
    },
    {
      "hrsh7th/cmp-cmdline", -- autocompletion for nvim commands
      event = { "VeryLazy" },
    },
    {
      "onsails/lspkind.nvim", -- nvim cmp icons
      event = { "VeryLazy" },
    },

    --[[ Snippets ]]
    -- snippets used in autocompletion
    {
      "L3MON4D3/LuaSnip",

      event = { "VeryLazy" },

      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)

      -- massive repo of popular snippets for autocompletion
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
      "saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
      event = { "VeryLazy" },
    },

    --[[ Autopairs ]]
    {
      "windwp/nvim-autopairs", -- autocomplete parentheses, brackets, etc...
      event = { "VeryLazy" },
    },

    --[[ File Formatting ]]
    {
      "mhartington/formatter.nvim", -- automatically format files on save
      event = { "VeryLazy" },
    },

    --[[ Telescope ]]
    -- fuzzy-finding
    {
      "nvim-telescope/telescope.nvim",
      event = { "VeryLazy" },
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = require "al.extra.telescope",
    },

    -- telescope for snippets
    {
      "benfowler/telescope-luasnip.nvim",
      event = { "VeryLazy" },
      module = "telescope._extensions.luasnip", -- if you wish to lazy-load
    },

    --[[ LSP - Language Server Protocol ]]
    {
      "williamboman/mason.nvim", -- simple to use language server installer
      event = { "VeryLazy" },
    },
    {
      "williamboman/mason-lspconfig.nvim", -- allows interop between mason and lsconfig
      event = { "VeryLazy" },
    },
    {
      "neovim/nvim-lspconfig", -- enable lsp
      event = { "VeryLazy" },
    },

    --[[ GIT ]]
    {
      "lewis6991/gitsigns.nvim", -- git indicators
      opts = {},
    },

    {
      "sindrets/diffview.nvim", -- git diff integration
      event = { "VeryLazy" },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = "al.extra.diffview",
    },

    --[[ GPT autocompletion ]]
    {
      "github/copilot.vim", -- github copilot in nvim
      event = { "VeryLazy" },
    },

    --[[ OTHER ]]
    { -- tells you all your keybinds
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = require "al.extra.whichkey",
    },

    -- pseudo "tabs" to work with nvim tree
    {
      "akinsho/bufferline.nvim",
      opts = require "al.extra.bufferline",
    },

    -- airline for lua
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "kyazdani42/nvim-web-devicons" },
      opts = require "al.extra.lualine",
    },

    -- filesystem tree
    {
      "kyazdani42/nvim-tree.lua",
      opts = require "al.extra.nvim-tree",
    },

    -- colorize CSS color codes
    {
      "norcalli/nvim-colorizer.lua",
      event = "VeryLazy",
      opts = {
        "*",
      },
    },
    -- improved UI interfaces
    {
      "stevearc/dressing.nvim",
      event = "VeryLazy",
      opts = {
        input = {
          win_options = {
            -- create new highlight groups that we can use to style dressing
            -- without bleeding over to other plugins
            winhighlight = "FloatBorder:DressingFloatBorder,FloatTitle:DressingFloatTitle,Normal:DressingInputText",
          },
        },
      },
    },

    {
      "folke/todo-comments.nvim",
      event = "VeryLazy",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = require "al.extra.todos",
    },

    --[[ Language Specific ]]
    {
      "lervag/vimtex", -- latex support
      event = "VeryLazy",
      config = function()
        require "al.extra.vimtex"
      end,
    },

    -- markdown preview
    {
      "iamcco/markdown-preview.nvim",
      event = "VeryLazy",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    },
  },

  -- install = { colorscheme = { "gruvbox" } },

  -- automatically check for plugin updates
  checker = { enabled = false },
}
