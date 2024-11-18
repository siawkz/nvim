return {
  "pteroctopus/faster.nvim",
  event = "BufReadPre",
  config = function()
    require("faster").setup()
  end,
}
