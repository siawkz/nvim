return {
  "mrjones2014/legendary.nvim",
  config = function()
    require("legendary").setup({
      select_prompt = " Legendary ",
      commands = {
        { ":Telescope live_grep", description = "Find Text ( live grep )" },
      },
    })
  end,
  keys = {
    { "<leader>C", "<Cmd>Legendary<CR>", desc = "Open Legendary" },
  },
}
