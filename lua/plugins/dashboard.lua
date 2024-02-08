return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    opts.config.header = require("utils.banners").dashboard()
  end,
}
