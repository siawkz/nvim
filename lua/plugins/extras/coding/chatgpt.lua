return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        mode = { "n", "v" },
        "<leader>ace",
        "<cmd>ChatGPTEditWithInstruction<cr>",
        desc = "Edit with Instruction",
      },
      { mode = { "n", "v" }, "<leader>acg", "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Correction" },
      { mode = { "n", "v" }, "<leader>act", "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
      { mode = { "n", "v" }, "<leader>ack", "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
      { mode = { "n", "v" }, "<leader>acd", "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
      { mode = { "n", "v" }, "<leader>aca", "<cmd>ChatGPTRun add_tests<cr>", desc = "Add Tests" },
      { mode = { "n", "v" }, "<leader>aco", "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize Code" },
      { mode = { "n", "v" }, "<leader>acs", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
      { mode = { "n", "v" }, "<leader>acf", "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs" },
      { mode = { "n", "v" }, "<leader>acx", "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain Code" },
      { mode = { "n", "v" }, "<leader>acr", "<cmd>ChatGPTRun roxygen_edit<cr>", desc = "Roxygen Edit" },
      {
        mode = { "n", "v" },
        "<leader>acl",
        "<cmd>ChatGPTRun code_readability_analysis<cr>",
        desc = "Code Readability Analysis",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>a", group = "ai" },
          { "<leader>ac", group = "chatgpt" },
        },
      },
    },
  },
}
