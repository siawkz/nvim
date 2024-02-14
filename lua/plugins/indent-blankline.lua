local M = {
  "lukas-reineke/indent-blankline.nvim",
}

M.config = function()
  local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
  }

  local hooks = require("ibl.hooks")
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  local palette = require("nightfox.palette").load(vim.g.colors_name)
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = palette.red.dim })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = palette.yellow.dim })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = palette.blue.dim })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = palette.orange.dim })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = palette.green.dim })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = palette.magenta.dim })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = palette.cyan.dim })
  end)
  hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
  require("ibl").setup({
    indent = { highlight = highlight, char = { "", "┊", "┆", "¦", "|", "¦", "┆", "┊", "" } },
    exclude = {
      buftypes = { "terminal", "nofile" },
      filetypes = {
        "alpha",
        "log",
        "gitcommit",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_watches",
        "dapui_breakpoints",
        "dapui_hover",
        "LuaTree",
        "dbui",
        "UltestSummary",
        "UltestOutput",
        "vimwiki",
        "markdown",
        "json",
        "txt",
        "vista",
        "NvimTree",
        "git",
        "TelescopePrompt",
        "undotree",
        "flutterToolsOutline",
        "org",
        "orgagenda",
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "Outline",
        "Trouble",
        "lspinfo",
        "", -- for all buffers without a file type
      },
    },
    scope = {
      enabled = true,
      show_start = false,
    },
  })
end

return M
