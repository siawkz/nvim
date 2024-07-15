return {
  {
    "stevearc/overseer.nvim",
    opts = {
      task_list = {
        direction = "bottom",
      },
    },
    keys = {
      { "<leader>ml", "<cmd>OverseerLoadBundle<cr>", desc = "Load Bundle" },
      { "<leader>ms", "<cmd>OverseerSaveBundle<cr>", desc = "Save Bundle" },
      { "<leader>mr", "<cmd>OverseerBuild<cr>", desc = "New Task" },
      { "<leader>mq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
      { "<leader>mf", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
      { "<leader>mt", "<cmd>OverseerToggle<cr>", desc = "Toggle Output" },
      { "<leader>rf", "<cmd>OverseerRun<cr>", desc = "Run" },
      { "<leader>rp", "<cmd>OverseerRunCmd<cr>", desc = "Run with Cmd" },
      { "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Toggle" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>m", group = "tasks" },
          { "<leader>r", group = "run" },
        },
      },
    },
  },
}
