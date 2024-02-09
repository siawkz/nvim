return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "isort", "pyright", "flake8" })
        end,
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.isort,
        nls.builtins.diagnostics.flake8,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "debugpy" })
        end,
      },
    },
    opts = function()
      require("dap").configurations.python = require("dap").configurations.python or {}
      table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "launch with options",
        program = "${file}",
        python = function() end,
        pythonPath = function()
          local path
          for _, server in pairs(vim.lsp.buf_get_clients()) do
            if server.name == "pyright" or server.name == "pylance" then
              path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
              break
            end
          end
          path = vim.fn.input("Python path: ", path or "", "file")
          return path ~= "" and vim.fn.expand(path) or nil
        end,
        args = function()
          local args = {}
          local i = 1
          while true do
            local arg = vim.fn.input("Argument [" .. i .. "]: ")
            if arg == "" then
              break
            end
            args[i] = arg
            i = i + 1
          end
          return args
        end,
        justMyCode = function()
          local yn = vim.fn.input("justMyCode? [y/n]: ")
          if yn == "y" then
            return true
          end
          return false
        end,
        stopOnEntry = function()
          local yn = vim.fn.input("stopOnEntry? [y/n]: ")
          if yn == "y" then
            return true
          end
          return false
        end,
        console = "integratedTerminal",
      })
    end,
  },
}
