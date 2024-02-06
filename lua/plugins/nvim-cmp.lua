local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  event = "VimEnter",
  opts = function(_, opts)
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- this way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })
  end,
}

M.config = function()
  local cmp = require("cmp")
  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  local kind_icons = {
    Class = "󰠱",
    Color = " ",
    Constant = "",
    Constructor = " ",
    Default = " ",
    Enum = "",
    EnumMember = " ",
    Event = " ",
    Field = "󰜢",
    File = "󰈚",
    Folder = " ",
    Function = " ",
    Keyword = " ",
    Interface = "",
    Implementation = "",
    Method = "󰆧",
    Module = "",
    Namespace = "󰌗",
    Number = "",
    Operator = "󰆕",
    Property = " ",
    Reference = "󰈇",
    Snippet = " ", -- ""," "," "
    spell = "󰓆",
    Struct = "󰙅",
    Text = "󰉿",
    TypeParameter = "  ",
    Undefined = "",
    Unit = "󰑭",
    Value = "󰎠",
    Variable = "󰀫",
    TypeAlias = "",
    Parameter = "",
    StaticMethod = "",
    Macro = "",
  }

  local cmp_sources = {
    buffer = "(Buffer)",
    copilot = "(Copilot)",
    cmp_tabnine = "(TabNine)",
    codeium = "(Codeium)",
    crates = "(Crates)",
    nvim_lua = "(NvLua)",
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.scroll_docs(-4),
      ["<C-j>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "cmp_tabnine", max_item_count = 3 },
      { name = "buffer", max_item_count = 5, keyword_length = 5 },
      { name = "copilot" },
      { name = "codeium" },
      { name = "path", max_item_count = 5 },
      { name = "luasnip", max_item_count = 3 },
      { name = "nvim_lua" },
      { name = "calc" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "latex_symbols" },
      { name = "crates" },
    }),

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        if entry.source.name == "cmdline" then
          vim_item.kind = "⌘"
          vim_item.menu = ""
          return vim_item
        end
        if entry.source.name == "codeium" then
          local detail = (entry.completion_item.data or {}).detail
          vim_item.kind = ""
          if detail and detail:find(".*%%.*") then
            vim_item.kind = vim_item.kind .. " " .. detail
          end

          if (entry.completion_item.data or {}).multiline then
            vim_item.kind = vim_item.kind .. " " .. "[ML]"
          end
        end

        if entry.source.name == "copilot" then
          vim_item.kind = ""
        end

        vim_item.menu = cmp_sources[entry.source.name] or vim_item.kind
        vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind

        return vim_item
      end,
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return M
