local M = {
  "mfussenegger/nvim-dap",
}

M.config = function()
  local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  -- NOTE: if you want to use `dap` instead of `RustDebuggables` you can use the following configuration
  if vim.fn.executable("lldb-vscode") == 1 then
    dap.adapters.lldbrust = {
      type = "executable",
      attach = { pidProperty = "pid", pidSelect = "ask" },
      command = "lldb-vscode",
      env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
    }
    dap.adapters.rust = dap.adapters.lldbrust
    dap.configurations.rust = {
      {
        type = "rust",
        request = "launch",
        name = "lldbrust",
        program = function()
          local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
          local metadata = vim.fn.json_decode(metadata_json)
          local target_name = metadata.packages[1].targets[1].name
          local target_dir = metadata.target_directory
          return target_dir .. "/debug/" .. target_name
        end,
        args = function()
          local inputstr = vim.fn.input("Params: ", "")
          local params = {}
          local sep = "%s"
          for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
            table.insert(params, str)
          end
          return params
        end,
      },
    }
  end

  dap.adapters.go = function(callback, _)
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
  dap.configurations.go = {
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

  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
  }

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {
        vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
        "${port}",
      },
    },
  }

  dap.configurations.typescript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "pwa-chrome",
      name = "Debug with Chrome",
      request = "attach",
      program = "${file}",
      -- cwd = "${workspaceFolder}",
      -- protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
      -- sourceMaps = true,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
    {
      type = "pwa-msedge",
      name = "Debug with Edge",
      request = "attach",
      program = "${file}",
      -- cwd = "${workspaceFolder}",
      -- protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
      -- sourceMaps = true,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
  }

  dap.configurations.javascript = dap.configurations.typescript

  --Java debugger adapter settings
  dap.configurations.java = {
    {
      name = "Debug (Attach) - Remote",
      type = "java",
      request = "attach",
      hostName = "127.0.0.1",
      port = 5005,
    },
    {
      name = "Debug Non-Project class",
      type = "java",
      request = "launch",
      program = "${file}",
    },
  }

  local path = vim.fn.glob(mason_path .. "packages/codelldb/extension/")
    or vim.fn.expand("~/") .. ".vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
  local lldb_cmd = path .. "adapter/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = lldb_cmd,
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = mason_path .. "packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
  }

  dap.configurations.cpp = {
    {
      name = "Launch file with gdb",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopAtEntry = true,
    },
    {
      name = "Attach to gdbserver :1234",
      type = "cppdbg",
      request = "launch",
      MIMode = "gdb",
      miDebuggerServerAddress = "localhost:1234",
      miDebuggerPath = "/usr/bin/gdb",
      cwd = "${workspaceFolder}",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
    },
    {
      name = "Launch file with lldb",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      args = function()
        local inputstr = vim.fn.input("Params: ", "")
        local params = {}
        local sep = "%s"
        for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
          table.insert(params, str)
        end
        return params
      end,

      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      runInTerminal = true,
    },
    {
      -- If you get an "Operation not permitted" error using this, try disabling YAMA:
      --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      name = "Attach to process with PID",
      type = "codelldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      arg = {},
      stopOnEntry = false,
    },
  }

  dap.configurations.c = dap.configurations.cpp

  dap.configurations.python = dap.configurations.python or {}
  table.insert(dap.configurations.python, {
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

  dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
      end,
      args = function()
        local inputstr = vim.fn.input("Params: ", "")
        local params = {}
        local sep = "%s"
        for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
          table.insert(params, str)
        end
        return params
      end,
    },
  }

  dap.adapters.perlsp = {
    type = "server",
    host = "127.0.0.1",
    port = "27011",
  }

  dap.configurations.perl = {
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
end

return M
