return {
  {
    "siawkz/nvim-cheatsh",
    cmd = { "Cheat", "CheatList" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>?", "<Cmd>CheatList<CR>", desc = "Cheat" },
    },
  },
}
