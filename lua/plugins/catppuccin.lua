return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    -- you can do it like this with a config function
    config = function()
      require("catppuccin").setup({
        integrations = {
          flash = false,
          hop = true,
          mason = true,
          neotree = true,
          window_picker = true,
          symbols_outline = true,
          which_key = true,
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = "catppuccin"
    end,
  },
}
