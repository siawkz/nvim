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

-- On every non-macOS box, route the system clipboard through OSC 52 so yanks
-- reach the host terminal (e.g. WezTerm on macOS) without needing xclip /
-- wl-copy on the remote. Covers:
--   - plain `ssh` sessions (SSH_TTY/SSH_CLIENT set)
--   - WezTerm `ssh_domains` / mux sessions (no SSH_TTY — shell is a child of
--     wezterm-mux-server, not ssh)
--   - any other remote terminal that speaks OSC 52
--
-- WezTerm honors OSC 52 *writes* (copy) but explicitly ignores *reads* (paste).
-- So copy → OSC 52, paste → unnamed register (`"+p` / `"*p` replay the last
-- yank). To paste host clipboard content into Neovim, use WezTerm's ⌘V /
-- Ctrl-Shift-V — it sends the text as keystrokes via bracketed paste.
--
-- Local macOS keeps the default `pbcopy`/`pbpaste` provider.
if vim.fn.has("macunix") == 0 then
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
