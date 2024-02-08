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
        "<leader>hbe",
        "<cmd>ChatGPTEditWithInstruction<cr>",
        desc = "Edit with Instruction",
      },
      { mode = { "n", "v" }, "<leader>hbg", "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Correction" },
      { mode = { "n", "v" }, "<leader>hbt", "<cmd>ChatGPTRun translate<cr>", desc = "Translate" },
      { mode = { "n", "v" }, "<leader>hbk", "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords" },
      { mode = { "n", "v" }, "<leader>hbd", "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring" },
      { mode = { "n", "v" }, "<leader>hba", "<cmd>ChatGPTRun add_tests<cr>", desc = "Add Tests" },
      { mode = { "n", "v" }, "<leader>hbo", "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize Code" },
      { mode = { "n", "v" }, "<leader>hbs", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize" },
      { mode = { "n", "v" }, "<leader>hbf", "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs" },
      { mode = { "n", "v" }, "<leader>hbx", "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain Code" },
      { mode = { "n", "v" }, "<leader>hbr", "<cmd>ChatGPTRun roxygen_edit<cr>", desc = "Roxygen Edit" },
      {
        mode = { "n", "v" },
        "<leader>hbl",
        "<cmd>ChatGPTRun code_readability_analysis<cr>",
        desc = "Code Readability Analysis",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        mode = { "n", "v" },
        ["<leader>h"] = { name = "+AI" },
        ["<leader>hb"] = { name = "+ChatGPT" },
      },
    },
  },
}
