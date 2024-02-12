return {
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "perlnavigator" })
        end,
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.perlimports,
        nls.builtins.formatting.perltidy,
      })
    end,
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
