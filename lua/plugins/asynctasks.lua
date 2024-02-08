return {
  {
    "skywind3000/asynctasks.vim",
    dependencies = {
      { "skywind3000/asyncrun.vim" },
    },
    init = function()
      vim.cmd([[
          let g:asyncrun_open = 8
          let g:asynctask_template = '~/.config/nvim/task_template.ini'
          let g:asynctasks_extra_config = ['~/.config/nvim/tasks.ini']
        ]])
    end,
    event = { "BufRead", "BufNew" },
    keys = {
      { "<leader>mf", "<cmd>AsyncTask file-build<cr>", desc = "File" },
      { "<leader>mp", "<cmd>AsyncTask project-build<cr>", desc = "Project" },
      { "<leader>me", "<cmd>AsyncTaskEdit<cr>", desc = "Edit" },
      { "<leader>ml", "<cmd>AsyncTaskList<cr>", desc = "List" },
      { "<leader>rf", "<cmd>AsyncTask file-run<cr>", desc = "File" },
      { "<leader>rp", "<cmd>AsyncTask project-run<cr>", desc = "Project" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>m"] = { name = "+Make" },
        ["<leader>r"] = { name = "+Run" },
      },
    },
  },
}
