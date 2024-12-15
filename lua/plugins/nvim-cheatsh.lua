return {
  {
    "siawkz/nvim-cheatsh",
    cmd = { "Cheat", "CheatList" },
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    keys = {
      { "<leader>H", "<Cmd>CheatList<CR>", desc = "Cheat" },
    },
  },
}
