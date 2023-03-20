local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
  return
end

-- format on save
-- vim.cmd [[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePre * FormatWrite
-- augroup END
-- ]]


-- formatters are opt-in
-- so you need to define them for the languages that you like
formatter.setup {
  -- Enable or disable logging
  logging = true,

  -- Set the log level
  log_level = vim.log.levels.WARN,

  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
