-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/utils/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>L")
vim.keymap.set("n", "<leader>ub", function()
  require("utils.colorscheme").ToggleColorScheme()
end, { desc = "Toggle Background" })

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("i", "<C-a>", "<Esc>ggVG<Cr>", opts)
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG<Cr>", opts)

vim.keymap.set("n", "<leader>cpd", function()
  require("utils.peek").Peek("definition")
end, { desc = "Definition" })
vim.keymap.set("n", "<leader>cpi", function()
  require("utils.peek").Peek("implementation")
end, { desc = "Implementation" })
vim.keymap.set("n", "<leader>cpt", function()
  require("utils.peek").Peek("typeDefinition")
end, { desc = "Type Definition" })
