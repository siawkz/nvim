-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/utils/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>L")

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "s", ":HopChar2MW<cr>", opts)
vim.api.nvim_set_keymap("n", "S", ":HopWordMW<cr>", opts)
vim.api.nvim_set_keymap(
  "n",
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "n",
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "o",
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "o",
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "",
  "t",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "",
  "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
  {}
)

vim.api.nvim_set_keymap("i", "<A-a>", "<Esc>ggVG<Cr>", opts)

vim.keymap.set("n", "<leader>cpd", function()
  require("utils.peek").Peek("definition")
end, { desc = "Definition" })
vim.keymap.set("n", "<leader>cpi", function()
  require("utils.peek").Peek("implementation")
end, { desc = "Implementation" })
vim.keymap.set("n", "<leader>cpt", function()
  require("utils.peek").Peek("typeDefinition")
end, { desc = "Type Definition" })
