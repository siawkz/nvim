local M = {
  floating_buf = nil,
  floating_win = nil,
  prev_result = nil,
}

local function compute_size(opts)
  local width = opts.width or math.min(120, math.floor(vim.o.columns * 0.8))
  local height = opts.height or math.min(20, math.floor(vim.o.lines * 0.5))
  return width, height
end

local function create_floating_file(location, opts)
  opts = opts or {}
  local close_events = opts.close_events or { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" }

  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end

  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end

  local range = location.targetRange or location.range
  local width, height = compute_size(opts)

  local float_opts = {
    relative = "cursor",
    width = width,
    height = height,
    row = 1,
    col = 0,
    border = opts.border or "rounded",
    focusable = true,
    style = nil,
  }

  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })

  local winnr = vim.api.nvim_open_win(bufnr, false, float_opts)
  vim.api.nvim_set_option_value("winblend", 0, { win = winnr })

  vim.api.nvim_win_set_cursor(winnr, { range.start.line + 1, range.start.character })
  vim.api.nvim_buf_set_var(bufnr, "lsp_floating_window", winnr)

  vim.api.nvim_create_autocmd(close_events, {
    buffer = bufnr,
    once = true,
    callback = function()
      pcall(vim.api.nvim_win_close, winnr, true)
    end,
  })

  return bufnr, winnr
end

local function preview_location_callback(result)
  if result == nil or vim.tbl_isempty(result) then
    return
  end

  local opts = { border = "rounded" }

  if vim.islist(result) then
    M.prev_result = result[1]
    M.floating_buf, M.floating_win = create_floating_file(result[1], opts)
  else
    M.prev_result = result
    M.floating_buf, M.floating_win = create_floating_file(result, opts)
  end
end

function M.open_file()
  local filepath = vim.fn.expand("%:.")

  if not filepath then
    vim.notify("peek: Unable to open the file!", vim.log.levels.ERROR)
    return
  end

  pcall(vim.api.nvim_win_close, M.floating_win, true)
  vim.cmd("edit " .. filepath)

  M.set_cursor_to_prev_pos(vim.api.nvim_get_current_win())
end

function M.set_cursor_to_prev_pos(winnr)
  local location = M.prev_result
  local range = location.targetRange or location.range
  vim.api.nvim_win_set_cursor(winnr or M.floating_win, { range.start.line + 1, range.start.character })
end

function M.Peek(what)
  if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
    local ok = pcall(vim.api.nvim_set_current_win, M.floating_win)
    if not ok then
      vim.notify("peek: You cannot edit the current file in a preview!", vim.log.levels.ERROR)
      return
    end

    M.set_cursor_to_prev_pos()

    vim.keymap.set("n", "<CR>", function()
      require("utils.peek").open_file()
    end, { buffer = M.floating_buf, noremap = true, silent = true })
  else
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if vim.tbl_isempty(clients) then
      vim.notify("peek: No active LSP client for this buffer.", vim.log.levels.WARN)
      return
    end
    local encoding = clients[1].offset_encoding or "utf-16"
    local params = vim.lsp.util.make_position_params(0, encoding)
    local ok = pcall(vim.lsp.buf_request, 0, "textDocument/" .. what, params, function(_, result)
      preview_location_callback(result)
    end)
    if not ok then
      vim.notify(
        'peek: Error calling LSP method "textDocument/' .. what .. '". The current language lsp might not support it.',
        vim.log.levels.ERROR
      )
    end
  end
end

return M
