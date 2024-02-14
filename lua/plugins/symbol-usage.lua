local M = {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
}

M.config = function()
  local text_format = function(symbol)
    local res = {}
    local ins = table.insert

    local round_start = { "", "SymbolUsageRounding" }
    local round_end = { "", "SymbolUsageRounding" }

    if symbol.references then
      local usage = symbol.references <= 1 and "usage" or "usages"
      local num = symbol.references == 0 and "no" or symbol.references
      ins(res, round_start)
      ins(res, { "󰌹 ", "SymbolUsageRef" })
      ins(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
      ins(res, round_end)
    end

    if symbol.definition then
      if #res > 0 then
        table.insert(res, { " ", "NonText" })
      end
      ins(res, round_start)
      ins(res, { "󰳽 ", "SymbolUsageDef" })
      ins(res, { symbol.definition .. " defs", "SymbolUsageContent" })
      ins(res, round_end)
    end

    if symbol.implementation then
      if #res > 0 then
        table.insert(res, { " ", "NonText" })
      end
      ins(res, round_start)
      ins(res, { "󰡱 ", "SymbolUsageImpl" })
      ins(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
      ins(res, round_end)
    end

    return res
  end

  local function h(name)
    return vim.api.nvim_get_hl(0, { name = name })
  end

  vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg })
  vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg })
  vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg })
  vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg })
  vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg })

  require("symbol-usage").setup({
    text_format = text_format,
    references = { enabled = true, include_declaration = false },
    definition = { enabled = true },
    implementation = { enabled = true },
  })
end

return M
