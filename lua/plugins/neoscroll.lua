return {
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup({
      easing_function = "quadratic",
      hide_cursor = true,
    })
  end,
  event = "BufRead",
}
