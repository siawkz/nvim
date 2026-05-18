local function set_mode(blink_mode)
  vim.g.copilot_blink_mode = blink_mode
  local s = require("copilot.suggestion")
  if blink_mode then
    -- Blink mode: silence ghost text, blink dropdown will show copilot
    if s.is_visible() then
      s.dismiss()
    end
    vim.b.copilot_suggestion_auto_trigger = false
  else
    -- Ghost mode: ghost auto-triggers, blink drops copilot from its source list
    vim.b.copilot_suggestion_auto_trigger = true
  end
  vim.notify("Copilot: " .. (blink_mode and "blink (Tab)" or "ghost (M-p)"), vim.log.levels.INFO)
end

return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
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
      { "<leader>acs", "<Cmd>Copilot status<CR>", desc = "Status" },
      {
        "<leader>acm",
        function()
          set_mode(not vim.g.copilot_blink_mode)
        end,
        desc = "Toggle Ghost ↔ Blink",
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        providers = {
          copilot = {
            enabled = function()
              return vim.g.copilot_blink_mode == true
            end,
          },
        },
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
          { "<leader>ac", group = "copilot settings" },
        },
      },
    },
  },
}
