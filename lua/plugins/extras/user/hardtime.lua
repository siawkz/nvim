return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    disable_mouse = false,
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "neo-tree" },
  },
  event = "VimEnter",
}
