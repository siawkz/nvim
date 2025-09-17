return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "perlnavigator", "perl-debug-adapter" })
        end,
      },
    },
    opts = {
      setup = {
        perlnavigator = function()
          require("lspconfig").perlnavigator.setup({
            root_dir = require("lspconfig.util").root_pattern(".root", ".git"),
          })
          return true
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      require("dap").adapters.perlsp = {
        type = "server",
        host = "127.0.0.1",
        port = "27011",
      }

      require("dap").configurations.perl = {
        {
          name = "Launch Perl",
          type = "perlsp",
          request = "launch",
          program = "${workspaceFolder}/${relativeFile}",
          reloadModules = true,
          stopOnEntry = false,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
