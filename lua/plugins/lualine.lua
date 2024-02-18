return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local kind_icons = {
      clock = "󰥔 ",
      ls_inactive = "󰒎 ",
      ls_active = "󰒍 ",
    }

    local palette = require("nightfox.palette").load(vim.g.colors_name)

    local colors = {
      none = "NONE",
      bg = palette.bg0,
      fg = palette.fg0,
      green = palette.green.base,
      red = palette.red.base,
      git = {
        change = palette.yellow.base,
        add = palette.green.base,
        delete = palette.red.base,
        conflict = palette.orange.base,
      },
    }

    local function clock()
      return kind_icons.clock .. os.date("%H:%M")
    end

    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    local function testing()
      if vim.g.testing_status == "running" then
        return " "
      end
      if vim.g.testing_status == "fail" then
        return ""
      end
      if vim.g.testing_status == "pass" then
        return " "
      end
      return nil
    end

    -- Config
    opts.options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    }
    opts.sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype", "overseer" },
      lualine_y = {},
      lualine_z = { "location" },
    }
    opts.inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    }
    opts.tabline = {}
    opts.winbar = {}
    opts.inactive_winbar = {}
    opts.extensions = {}

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.o.columns > 80
      end,
      hide_small = function()
        return vim.o.columns > 140
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(opts.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(opts.sections.lualine_x, component)
    end

    ins_left({
      "diff",
      source = diff_source,
      symbols = { added = "  ", modified = " ", removed = " " },
      diff_color = {
        added = { fg = colors.git.add },
        modified = { fg = colors.git.change },
        removed = { fg = colors.git.delete },
      },
      color = {},
      cond = nil,
    })

    ins_left({
      provider = function()
        return testing()
      end,
      enabled = function()
        return testing() ~= nil
      end,
      hl = {
        fg = colors.fg,
      },
      left_sep = " ",
      right_sep = {
        str = " |",
        hl = { fg = colors.fg },
      },
    })

    ins_right({
      function()
        return ""
      end,
      color = function()
        local buf = vim.api.nvim_get_current_buf()
        local ts = vim.treesitter.highlighter.active[buf]
        return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
      end,
      cond = conditions.hide_in_width,
    })

    ins_right({
      function(msg)
        msg = msg or kind_icons.ls_inactive .. "LS Inactive"
        local buf_clients = vim.lsp.get_active_clients()
        if next(buf_clients) == nil then
          if type(msg) == "boolean" or #msg == 0 then
            return kind_icons.ls_inactive .. "LS Inactive"
          end
          return msg
        end
        local buf_ft = vim.bo.filetype
        local buf_client_names = {}
        local only_lsp = ""
        local lsp_icon = kind_icons.ls_active

        for _, client in pairs(buf_clients) do
          if client.name ~= "null-ls" then
            local _added_client = client.name
            only_lsp = only_lsp .. _added_client
            _added_client = string.sub(client.name, 1, 7)
            if client.name == "copilot" then
              lsp_icon = " "
            else
              table.insert(buf_client_names, _added_client)
            end
          end
        end

        local function list_registered_providers_names(filetype)
          local s = require("null-ls.sources")
          local available_sources = s.get_available(filetype)
          local registered = {}
          for _, source in pairs(available_sources) do
            for method in pairs(source.methods) do
              registered[method] = registered[method] or {}
              table.insert(registered[method], source.name)
            end
          end
          return registered
        end

        local function list_supported_formatters(filetype)
          local registered = list_registered_providers_names(filetype)
          return registered[require("null-ls").methods.FORMATTING] or {}
        end

        -- add formatter
        local supported_formatters = {}
        for _, fmt in pairs(list_supported_formatters(buf_ft)) do
          local _added_formatter = fmt
          _added_formatter = string.sub(fmt, 1, 4)
          table.insert(supported_formatters, _added_formatter)
        end
        vim.list_extend(buf_client_names, supported_formatters)

        local function list_supported_linters(filetype)
          local registered_providers = list_registered_providers_names(filetype)
          local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
            return registered_providers[m] or {}
          end, {
            require("null-ls").methods.DIAGNOSTICS,
            require("null-ls").methods.DIAGNOSTICS_ON_OPEN,
            require("null-ls").methods.DIAGNOSTICS_ON_SAVE,
          }))

          return providers_for_methods
        end

        -- add linter
        local supported_linters = {}
        for _, lnt in pairs(list_supported_linters(buf_ft)) do
          local _added_linter = lnt
          _added_linter = string.sub(lnt, 1, 4)
          table.insert(supported_linters, _added_linter)
        end
        vim.list_extend(buf_client_names, supported_linters)

        if conditions.hide_small() then
          return lsp_icon .. table.concat(buf_client_names, ", ")
        elseif conditions.hide_in_width() then
          return only_lsp
        else
          return string.sub(only_lsp, 1, 5)
        end
      end,
      color = { fg = colors.fg },
      cond = conditions.hide_in_width,
    })
    ins_right({
      function()
        local function format_file_size(file)
          local size = vim.fn.getfsize(file)
          if size <= 0 then
            return ""
          end
          local sufixes = { "b", "k", "m", "g" }
          local i = 1
          while size > 1024 do
            size = size / 1024
            i = i + 1
          end
          return string.format("%.1f%s", size, sufixes[i])
        end

        local file = vim.fn.expand("%:p")
        if string.len(file) == 0 then
          return ""
        end
        return format_file_size(file)
      end,
      color = { fg = colors.fg },
      cond = conditions.buffer_not_empty and conditions.hide_small,
    })

    table.insert(opts.sections.lualine_y, {
      clock,
      cond = conditions.hide_small,
      color = { fg = colors.fg, bg = colors.bg },
    })

    table.insert(opts.sections.lualine_z, {
      function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
      end,
      padding = 0,
      color = { fg = colors.fg, bg = colors.bg },
      cond = nil,
    })
  end,
}
