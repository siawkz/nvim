return {
  {
    "siawkz/nvim-cheatsh",
    cmd = { "Cheat", "CheatList" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>H", "<Cmd>CheatList<CR>", desc = "Cheat" },
    },
  },
}
