return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.root_dir = opts.root_dir
      or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.prettierd.with({
        condition = function(utils)
          return not utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
        end,
        prefer_local = "node_modules/.bin",
      }),
      nls.builtins.formatting.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
        end,
        prefer_local = "node_modules/.bin",
      }),
      nls.builtins.formatting.csharpier,
      -- nls.builtins.formatting.clang_format.with({
      -- 	filetypes = { "c", "cpp" },
      -- }),
      nls.builtins.formatting.google_java_format,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.gofumpt,
      nls.builtins.formatting.cmake_format,
      nls.builtins.formatting.black,
      nls.builtins.formatting.isort,
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.shellharden,
      nls.builtins.formatting.scalafmt,
      nls.builtins.formatting.sqlformat,
      nls.builtins.formatting.terraform_fmt.with({
        filetypes = { "terraform", "tf", "terraform-vars", "hcl" },
      }),
      nls.builtins.formatting.perlimports,
      nls.builtins.formatting.perltidy,
      nls.builtins.diagnostics.semgrep.with({
        filetypes = { "python", "go", "cs", "terraform" },
        args = { "--config", "auto", "-q", "--json", "--timeout", "0", "$FILENAME" },
        timeout = 30000,
        method = nls.methods.DIAGNOSTICS_ON_SAVE,
      }),
      nls.builtins.diagnostics.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
        end,
        prefer_local = "node_modules/.bin",
      }),
      nls.builtins.diagnostics.shellcheck,
      -- nls.builtins.diagnostics.cpplint,
      nls.builtins.code_actions.gomodifytags,
      -- nls.builtins.diagnostics.luacheck,
      nls.builtins.code_actions.eslint_d.with({
        condition = function(utils)
          return utils.root_has_file({ ".eslintrc", ".eslintrc.js" })
        end,
        prefer_local = "node_modules/.bin",
      }),
      nls.builtins.code_actions.refactoring.with({
        filetypes = {
          "typescript",
          "javascript",
          "lua",
          -- "c",
          -- "cpp",
          "go",
          "python",
          "java",
          "php",
        },
      }),
    })
  end,
}
