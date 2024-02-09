return {
  {
    -- Disable flash
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    cmd = { "HopChar1CurrentLineAC", "HopChar1CurrentLineBC", "HopChar2MW", "HopWordMW" },
    config = function()
      require("hop").setup()
    end,
  },
}
