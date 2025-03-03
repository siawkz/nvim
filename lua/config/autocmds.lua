-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = 40 })
  end,
})

-- rainbow_csv when it is txt
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.txt",
  command = "set filetype=tsv",
})

vim.opt.updatetime = 200

local N = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function encode_base64(data)
  local data1 = (
    data:gsub(
      ".",
      --- @param x string
      --- @return string
      function(x)
        local r, b = "", x:byte()
        for i = 8, 1, -1 do
          r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
        end
        return r
      end
    ) .. "0000"
  )

  local data2 = data1:gsub(
    "%d%d%d?%d?%d?%d?",
    --- @param x string
    --- @return string
    function(x)
      if #x < 6 then
        return ""
      end
      local c = 0
      for i = 1, 6 do
        c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
      end
      return N:sub(c + 1, c + 1)
    end
  )

  local suffix = ({ "", "==", "=" })[#data % 3 + 1]

  return data2 .. suffix
end

local function osc52_copy(text)
  local text_b64 = encode_base64(text)
  local osc = string.format("%s]52;c;%s%s", string.char(0x1b), text_b64, string.char(0x07))
  io.stderr:write(osc)
end

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- Check if clipboard is available
    if vim.fn.has("clipboard") == 1 then
      return
    else
      osc52_copy(vim.fn.getreg(vim.v.event.regname))
    end
  end,
})
