return {
  "abecodes/tabout.nvim",
  config = function()
    require("tabout").setup({
      completion = false,
      ignore_beginning = false,
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
      },
    })
  end,
}
