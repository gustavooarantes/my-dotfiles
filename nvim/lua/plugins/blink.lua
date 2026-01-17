return {
  "saghen/blink.cmp",
  version = "v0.*",
  opts = function(_, opts)
    opts.cmdline = nil

    opts.keymap = {
      preset = "none",
      ["<CR>"] = { "accept", "fallback" },
      ["<Esc>"] = { "hide", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
    }

    opts.sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    }

    opts.completion = {
      documentation = { auto_show = true, window = { border = "rounded" } },
      menu = { border = "rounded" },
    }

    return opts
  end,
}
