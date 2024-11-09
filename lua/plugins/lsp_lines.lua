return {
  url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()
    vim.diagnostic.config({
      virtual_lines = false,
    })
    Snacks.toggle({
      name = "LSP Lines",
      get = function()
        return vim.diagnostic.config().virtual_lines
      end,
      set = function(state)
        vim.diagnostic.config({
          virtual_lines = state,
        })
      end,
    }):map("<leader>uv")
  end,
}
