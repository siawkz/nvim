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
      servers = {
        perlnavigator = {
          root_dir = require("lspconfig.util").root_pattern(".root", ".git"),
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        perl = { "perltidy" },
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
