return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = { filetypes = { "html", "jsp", "aspx" } },
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(
              "tailwind.config.js",
              "tailwind.config.ts",
              "postcss.config.js"
            )(...)
          end,
        },
        emmet_language_server = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
        },
        vtsls = {
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },
      },
    },
  },

  {
    "yioneko/nvim-vtsls",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("vtsls").config(opts)
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "vtsls",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "emmet-language-server",
        "eslint-lsp",
        "prettierd",
      },
    },
  },
}
