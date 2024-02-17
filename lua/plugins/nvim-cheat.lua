return {
  {
    "siawkz/nvim-cheatsh",
    event = "VimEnter",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>?", "<Cmd>CheatList<CR>", desc = "Cheat" },
    },
  },
}
