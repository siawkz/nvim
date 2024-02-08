return {
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    version = "v1.74.1",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    lazy = true,
    event = { "BufReadPre", "BufNew" },
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = os.getenv("HOME") .. "/.local/share/nvim/lazy/vscode-js-debug",
        adapters = { "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      })
    end,
  },
}
