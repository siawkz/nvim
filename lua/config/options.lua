-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false
vim.g.root_spec = { ".root", "lsp", { ".git", "lua" }, "cwd" }

-- Copilot UI mode:
--   ai_cmp = true                 → blink-copilot source is *registered* (so we can toggle to it)
--   copilot_blink_mode = false    → but *disabled* by default, so copilot stays out of blink
--   copilot-custom.lua            → ghost text on by default; <leader>acm flips modes
-- Net result: default = ghost only; toggle = blink-with-copilot only.
vim.g.ai_cmp = true
vim.g.copilot_blink_mode = false

-- Always sync to system clipboard so yanks land in "+ / "*
vim.opt.clipboard = "unnamedplus"

-- When running over SSH, route the system clipboard through OSC 52 so yanks
-- on the remote box reach the local terminal (WezTerm on macOS).
--
-- WezTerm honors OSC 52 *writes* (copy) but explicitly ignores *reads* (paste)
-- for security. So we wire copy → OSC 52 and paste → unnamed register, which
-- means `"+p` / `"*p` will replay whatever was last yanked.
-- To paste real host clipboard content into Neovim, use WezTerm's own paste
-- shortcut (⌘V / Ctrl-Shift-V) — it sends the text as keystrokes, which Neovim
-- captures via bracketed paste regardless of clipboard provider.
if os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil then
  local osc52 = require("vim.ui.clipboard.osc52")
  local function register_paste(_)
    return function()
      return vim.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"')
    end
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = register_paste("+"),
      ["*"] = register_paste("*"),
    },
  }
end
