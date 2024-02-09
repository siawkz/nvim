return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "netcoredbg" })
        end,
      },
    },
    opts = function()
      require("dap").adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }
      require("dap").configurations.cs = {
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
    end,
  },
}
