-- set colorscheme here
local colorscheme = "melange"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end



-- custom highlight groups
-- use `:hi` to see all highlight groups

-- hide tildes at end of buffers
-- vim.cmd [[ set fillchars=vert:\ ,eob:\ ]]
vim.cmd [[ set fillchars=eob:\ ]]


-- make NvimTree's background color inline with floating windows
vim.cmd [[ highlight link NvimTreeNormal NormalFloat ]]

-- vim.cmd [[ highlight NvimTreeNormal guibg=#FF0000 ]]

-- update the nvim tree split highlight group
-- this code copies the background color of the NormalFloat highlight group and
-- sets the background and foreground of the split highlight group to it. This
-- essentially removes the ugly vertical line for NvimTree's buffer only.
nf = vim.api.nvim_get_hl_by_name('NormalFloat', true)
vim.api.nvim_set_hl(0, 'NvimTreeVertSplit', {
  fg = nf.background,
  bg = nf.background
})
