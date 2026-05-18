return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Check if chafa is installed
    -- If not, use header instead of terminal
    if vim.fn.executable("chafa") == 0 then
      opts.dashboard = {
        preset = {
          header = require("utils.banners").dashboard(),
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      }
      return
    end
    opts.dashboard = {
      preset = {
        header = require("utils.banners").dashboard(),
      },
      sections = {
        {
          section = "terminal",
          cmd = "chafa ~/.config/nvim/static/mononico.png --format symbols --symbols vhalf --size 60x22 --stretch; sleep .1",
          height = 22,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    }

    vim.api.nvim_set_option_value("colorcolumn", "80", {})
    Snacks.toggle({
      name = "Color Column",
      get = function()
        return vim.api.nvim_get_option_value("colorcolumn", {}) == "80"
      end,
      set = function(state)
        vim.api.nvim_set_option_value("colorcolumn", state and "80" or "", {})
      end,
    }):map("<leader>u|")
  end,
}
