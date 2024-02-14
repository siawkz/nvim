local M = {}

function M.ToggleColorScheme()
  local colorscheme = vim.g.colors_name
  if colorscheme == "carbonfox" then
    vim.cmd("colorscheme dayfox")
  else
    vim.cmd("colorscheme carbonfox")
  end
  -- reload lualine
  require("lazy.core.loader").reload(require("lazy.core.config").plugins["lualine.nvim"])
  -- reload nvim-window-picker
  require("lazy.core.loader").reload(require("lazy.core.config").plugins["nvim-window-picker"])
  -- reload indent-blankline
  require("lazy.core.loader").reload(require("lazy.core.config").plugins["indent-blankline.nvim"])
  -- reload symbol-usage
  require("lazy.core.loader").reload(require("lazy.core.config").plugins["symbol-usage.nvim"])
end

return M
