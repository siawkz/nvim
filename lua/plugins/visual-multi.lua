return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_maps = {
      ["Add Cursor Down"] = "<C-M-j>",
      ["Add Cursor Up"] = "<C-M-k>",
    }
  end,
}
