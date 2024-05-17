return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function(_, opts)
      local cmp = require("cmp")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            elseif cmp.get_active_entry() then
              cmp.select_next_item()
            else
              cmp.select_next_item({ count = 0 })
            end
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
        }),
      })

      opts.experimental = {
        ghost_text = false,
      }

      table.insert(opts.sources, { name = "nvim_lua" })
      table.insert(opts.sources, { name = "treesitter" })
      table.insert(opts.sources, { name = "emoji" })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline({
          ["<Tab>"] = {
            c = function(_)
              if cmp.visible() then
                if #cmp.get_entries() == 1 then
                  cmp.confirm({ select = true })
                elseif cmp.get_active_entry() then
                  cmp.select_next_item()
                else
                  cmp.select_next_item({ count = 0 })
                end
              else
                cmp.complete()
                if #cmp.get_entries() == 1 then
                  cmp.confirm({ select = true })
                end
              end
            end,
          },
        }),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<Tab>"] = {
            c = function(_)
              if cmp.visible() then
                if #cmp.get_entries() == 1 then
                  cmp.confirm({ select = true })
                elseif cmp.get_active_entry() then
                  cmp.select_next_item()
                else
                  cmp.select_next_item({ count = 0 })
                end
              else
                cmp.complete()
                if #cmp.get_entries() == 1 then
                  cmp.confirm({ select = true })
                end
              end
            end,
          },
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
