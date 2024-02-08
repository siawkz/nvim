-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/utils/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cpd", function()
  require("utils.peek").Peek("definition")
end, { desc = "Definition" })
vim.keymap.set("n", "<leader>cpi", function()
  require("utils.peek").Peek("implementation")
end, { desc = "Implementation" })
vim.keymap.set("n", "<leader>cpt", function()
  require("utils.peek").Peek("typeDefinition")
end, { desc = "Type Definition" })
