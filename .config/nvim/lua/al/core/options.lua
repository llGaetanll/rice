local options = {
    backup = false,                          -- creates a backup file
    cmdheight = 1,                           -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "",                              -- disable the mouse
    pumheight = 10,                          -- pop up menu height
    shortmess = "IfilnxtToOF",               -- don't show nvim splash screen

    laststatus = 3,                          -- remove status lines on upper windows if windows are stacked vertically
    showtabline = 2,                         -- Always show tabs

    -- TABS
    smartcase = true,       -- Smart case
    autoindent = true,      -- Copy indent from current line when starting new line
    smartindent = true,     -- Smart auto-indenting for some languages
    expandtab = true,       -- Convert tabs to spaces
    shiftwidth = 4,         -- The number of spaces inserted for each indentation
    tabstop = 4,            -- Insert 2 spaces for a tab

    splitbelow = true,      -- Force all horizontal splits to go below current window
    splitright = true,      -- Force all vertical splits to go to the right of current window

    swapfile = false,       -- Creates a swapfile
    termguicolors = true,   -- Set term gui colors (most terminals support this)
    timeoutlen = 300,       -- Time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,        -- Enable persistent undo
    updatetime = 300,       -- Faster completion (4000ms default)

    cursorline = false,     -- highlight the current line
    number = true,          -- set numbered lines
    relativenumber = false, -- set relative numbered lines
    numberwidth = 4,        -- set number column width to 2 {default 4}

    -- Folding
    foldmethod = "indent",     -- folds based on indent
    foldlevel = 9,             -- folds off by default

    signcolumn = "yes",        -- always show the sign column, otherwise it would shift the text each time the LSP complains
    wrap = false,              -- whether to wrap lines
    linebreak = false,         -- companion to wrap, don't split words
    tw = 80,                   -- wrap lines at 80 characters

    scrolloff = 2,             -- minimal number of screen lines to keep above and below the cursor
    sidescrolloff = 2,         -- minimal number of screen columns either side of cursor if wrap is `false`

    guifont = "monospace:h17", -- the font used in graphical neovim applications
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- enable spellcheck inside of .tex or .md files
vim.cmd [[
  autocmd FileType tex,md setlocal spell spelllang=en_us
]]
