return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
  },
  opts = {
    detection_methods = { "pattern", "lsp" },
    patterns = {
      ".git",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "Makefile",
      "package.json",
      "pyproject.toml",
      "go.mod",
      "Cargo.toml",
      "pom.xml",
      "build.gradle",
      "*.sln",
      "*.csproj",
    },
    manual_mode = false,
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("telescope").load_extension("projects")
  end,
}
