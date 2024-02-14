return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "helm-ls" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "towolf/vim-helm",
        ft = "helm",
      },
    },
    opts = {
      setup = {
        helm_ls = function()
          require("lspconfig").helm_ls.setup({
            settings = {
              ["helm-ls"] = {
                yamlls = {
                  path = "yaml-language-server",
                },
              },
            },
          })
        end,
        yamlls = function()
          require("lspconfig").yamlls.setup({})
        end,
      },
    }
  },
}
