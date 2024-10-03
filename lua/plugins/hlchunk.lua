local M = {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  local palette = require("nightfox.palette").load(vim.g.colors_name)
  require("hlchunk").setup({
    chunk = {
      enable = true,
      style = palette.fg2,
    },
    indent = {
      enable = true,
      chars = { "", "┊", "┆", "¦", "|", "¦", "┆", "┊", "" },
      style = {
        palette.red.dim,
        palette.yellow.dim,
        palette.blue.dim,
        palette.orange.dim,
        palette.green.dim,
        palette.magenta.dim,
        palette.cyan.dim,
      },
      exclude_filetypes = {
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
    line_num = {
      enable = true,
      style = palette.fg2,
    },
  })
end

return M
