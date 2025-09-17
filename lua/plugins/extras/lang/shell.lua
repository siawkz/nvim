return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "shfmt", "shellharden", "bash-language-server" })
      end,
    },
  },
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.shellharden,
    })
  end,
}
