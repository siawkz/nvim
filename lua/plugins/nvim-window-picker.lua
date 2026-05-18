return {
  "s1n7ax/nvim-window-picker",
  version = "v2.*",
  config = function()
    local palette = require("nightfox.palette").load(vim.g.colors_name)
    require("window-picker").setup({
      hint = "floating-big-letter",
      autoselect_one = true,
      include_current = false,
      filter_rules = {
        bo = {
          filetype = {
            "snacks_picker_list",
            "snacks_picker_input",
            "snacks_picker_preview",
            "snacks_notif",
            "snacks_notif_history",
            "snacks_dashboard",
            "snacks_terminal",
            "snacks_layout_box",
            "snacks_input",
            "notify",
            "quickfix",
          },
          buftype = { "terminal" },
        },
      },
      other_win_hl_color = palette.bg2,
      current_win_hl_color = palette.bg3,
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
      "<leader>wx",
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
