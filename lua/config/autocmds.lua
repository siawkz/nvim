-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = 40 })
  end,
})

-- format on save
local fmtGroup = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = fmtGroup,
  pattern = { "*.lua", "*.go", "*.html", "*.rs", "*.json", "*.py" },
  command = "lua vim.lsp.buf.format({ async = false })",
})

vim.api.nvim_create_augroup("_nvim_user", {})
-- Autocommands
vim.cmd([[
  " disable syntax highlighting in big files
  function! DisableSyntaxTreesitter()
      echo("Big file, disabling syntax, treesitter and folding")
      if exists(':TSBufDisable')
          exec 'TSBufDisable autotag'
          exec 'TSBufDisable highlight'
      endif

      set foldmethod=manual
      syntax clear
      syntax off
      filetype off
      set noundofile
      set noswapfile
      set noloadplugins
      set lazyredraw
  endfunction

  augroup BigFileDisable
      autocmd!
      autocmd BufReadPre,FileReadPre * if getfsize(expand("%")) > 1024 * 1024 | exec DisableSyntaxTreesitter() | endif
  augroup END
    ]])
