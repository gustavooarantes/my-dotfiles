return {
  { "b0o/SchemaStore.nvim", lazy = true, version = false },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- === JSON ===
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },

        -- === YAML (Kubernetes, GitHub Actions, Cloud-init) ===
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use the plugin
                enable = false,
                url = "",
              },
            },
          },
        },

        -- === XML ===
        lemminx = {},

        -- === DOCKER ===
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "json-lsp",
        "yaml-language-server",
        "lemminx",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "hadolint",
      },
    },
  },
}
