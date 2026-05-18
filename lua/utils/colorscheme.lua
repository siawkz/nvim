local M = {}

function M.ToggleColorScheme()
  local colorscheme = vim.g.colors_name
  if colorscheme == "carbonfox" then
    vim.cmd("colorscheme dayfox")
  else
    vim.cmd("colorscheme carbonfox")
  end
  local loader = require("lazy.core.loader")
  local plugins = require("lazy.core.config").plugins
  for _, name in ipairs({ "lualine.nvim", "nvim-window-picker", "symbol-usage.nvim", "snacks.nvim" }) do
    if plugins[name] then
      loader.reload(plugins[name])
    end
  end
end

return M
