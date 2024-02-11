return {
  "vuki656/package-info.nvim",
  config = function()
    require("package-info").setup()
  end,
  lazy = true,
  event = { "BufReadPre", "BufNew" },
}
