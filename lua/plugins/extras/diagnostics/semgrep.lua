return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "semgrep" })
        end,
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.semgrep.with({
          filetypes = { "python", "go", "cs", "terraform" },
          args = { "--config", "auto", "-q", "--json", "--timeout", "0", "$FILENAME" },
          timeout = 30000,
          method = nls.methods.DIAGNOSTICS_ON_SAVE,
        }),
      })
    end,
  },
}
