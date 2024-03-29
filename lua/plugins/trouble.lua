return {
  -- change trouble config
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        auto_open = false,
        auto_close = true,
        padding = false,
        height = 10,
        use_diagnostic_signs = true,
      })
    end,
    event = "VeryLazy",
    cmd = "Trouble",
  },
}
