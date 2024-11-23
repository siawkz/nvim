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
  end,
}
