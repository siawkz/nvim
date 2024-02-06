return {
  "s1n7ax/nvim-window-picker",
  version = "v2.*",
  config = function()
    require("window-picker").setup({
      autoselect_one = true,
      include_current = false,
      filter_rules = {
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

          -- if the buffer type is one of following, the window will be ignored
          buftype = { "terminal" },
        },
      },
      other_win_hl_color = "#e35e4f",
    })
  end,
  keys = {
    {
      "<leader>wp",
      function()
        local picked_window_id = require("window-picker").pick_window({ include_current_win = true })
          or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end,
      desc = "Pick Window",
    },
    {
      "<leader>ws",
      function()
        local window = require("window-picker").pick_window({ include_current_win = false })
        local target_buffer = vim.fn.winbufnr(window)
        vim.api.nvim_win_set_buf(window, 0)
        vim.api.nvim_win_set_buf(0, target_buffer)
      end,
      desc = "Swap Window",
    },
  },
}
