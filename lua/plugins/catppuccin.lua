return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  opts = function(_, opts)
    opts.integrations.flash = false
    opts.integrations.hop = true
  end,
}
