return {
  {
    "olexsmir/gopher.nvim",
    config = function()
      require("gopher").setup({
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          gotests = "gotests",
          impl = "impl",
          iferr = "iferr",
        },
      })
    end,
    ft = { "go", "gomod" },
    event = { "BufRead", "BufNew" },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "delve" })
        end,
      },
      {
        "leoluz/nvim-dap-go",
        config = true,
      },
    },
    opts = function()
      require("dap").adapters.go = function(callback, _)
        local stdout = vim.loop.new_pipe(false)
        local handle
        local pid_or_err
        local port = 38697
        local opts = {
          stdio = { nil, stdout },
          args = { "dap", "-l", "127.0.0.1:" .. port },
          detached = true,
        }
        handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
          stdout:close()
          handle:close()
          if code ~= 0 then
            print("dlv exited with code", code)
          end
        end)
        assert(handle, "Error running dlv: " .. tostring(pid_or_err))
        stdout:read_start(function(err, chunk)
          assert(not err, err)
          if chunk then
            vim.schedule(function()
              require("dap.repl").append(chunk)
            end)
          end
        end)
        -- Wait for delve to start
        vim.defer_fn(function()
          callback({ type = "server", host = "127.0.0.1", port = port })
        end, 100)
      end
      -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
      require("dap").configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug with args",
          request = "launch",
          program = "${file}",
          args = function()
            local argument_string = vim.fn.input("Program arg(s): ")
            return vim.fn.split(argument_string, " ", true)
          end,
        },
        {
          type = "go",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
          type = "go",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
    end,
  },
}
