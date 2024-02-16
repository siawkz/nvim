return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "svelte-language-server" })
    end,
  },
  {
    "vuki656/package-info.nvim",
    config = function()
      require("package-info").setup()
    end,
    lazy = true,
    event = { "BufReadPre", "BufNew" },
  },
}
