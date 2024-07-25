return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-p>",
          accept_word = "<M-w>",
          accept_line = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        ["*"] = false,
        python = true,
        lua = true,
        go = true,
        rust = true,
        html = true,
        -- c = true,
        -- cpp = true,
        java = true,
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
        svelte = true,
        cs = true,
        terraform = true,
        dockerfile = true,
        markdown = true,
        sql = true,
        sh = true,
        perl = true,
      },
    },
    keys = {
      { "<leader>aca", "<Cmd>Copilot! attach<CR>", desc = "Force Attach" },
      { "<leader>ace", "<Cmd>Copilot enable<CR>", desc = "Enable" },
      { "<leader>acd", "<Cmd>Copilot disable<CR>", desc = "Disable" },
      { "<leader>act", "<Cmd>Copilot suggestion<CR>", desc = "Toggle Suggestions" },
      { "<leader>acs", "<Cmd>Copilot status<CR>", desc = "Status" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>a", group = "ai" },
          { "<leader>ac", group = "copilot settings" },
        },
      },
    },
  },
}
