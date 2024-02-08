return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>br", false },
    { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "Close buffer" },
    { "<leader>bs", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
  },
}
