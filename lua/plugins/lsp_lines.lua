return {
  url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  lazy = true,
  config = function()
    require("lsp_lines").setup()
  end,
  keys = {
    {
      "<leader>v",
      function()
        require("lsp_lines").toggle()
      end,
      desc = "Toggle LSP Lines",
    },
  },
}
