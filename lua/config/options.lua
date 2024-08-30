-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.g.root_spec = { ".root", "lsp", { ".git", "lua" }, "cwd" }

if os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil then
  local function my_paste(_)
    return function(_)
      local content = vim.fn.getreg('"')
      return vim.split(content, "\n")
    end
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = my_paste("+"),
      ["*"] = my_paste("*"),
    },
  }
end
