return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = require("utils.banners").dashboard(),
      },
    },
  },
}
