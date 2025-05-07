return {
  {
    "mason-org/mason.nvim",
    version = "1.11.0",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "stylua", "prettier" })
    end,
  },
  { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
}
