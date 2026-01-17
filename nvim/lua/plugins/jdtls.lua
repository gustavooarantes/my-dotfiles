local home = vim.env.HOME

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local ok, jdtls = pcall(require, "jdtls")
      if not ok then
        return
      end

      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local jdtls_path = mason_path .. "/packages/jdtls"
      local lombok_path = jdtls_path .. "/lombok.jar"
      local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

      local function get_workspace()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        return home .. "/jdtls-workspace/" .. project_name
      end

      local function get_bundles()
        local bundles = {}
        local java_debug_path = mason_path .. "/packages/java-debug-adapter/extension/server"
        local java_debug_jar = vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar", true)

        if java_debug_jar and java_debug_jar ~= "" then
          table.insert(bundles, java_debug_jar)
        end

        local java_test_path = mason_path .. "/packages/java-test/extension/server"
        local java_test_jars = vim.split(vim.fn.glob(java_test_path .. "/*.jar", true), "\n")

        for _, j in ipairs(java_test_jars) do
          if j ~= "" then
            table.insert(bundles, j)
          end
        end
        return bundles
      end

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local extendedClientCapabilities = jdtls.extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

      local function start_jdtls()
        local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
        if not root_dir then
          return
        end

        local workspace_dir = get_workspace()
        local system_os = (vim.fn.has("mac") == 1 and "mac") or (vim.fn.has("win32") == 1 and "win") or "linux"

        if vim.fn.filereadable(launcher_jar) == 0 then
          return
        end

        local config = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx4g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-javaagent:" .. lombok_path,
            "-jar",
            launcher_jar,
            "-configuration",
            jdtls_path .. "/config_" .. system_os,
            "-data",
            workspace_dir,
          },
          root_dir = root_dir,
          settings = {
            java = {
              home = "/usr/lib/jvm/java-21-openjdk",
              eclipse = { downloadSources = true },
              maven = { downloadSources = true },
              referencesCodeLens = { enabled = true },
              references = { includeDecompiledSources = true },
              format = {
                enabled = false,
              },
              configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                  { name = "JavaSE-8", path = "/usr/lib/jvm/java-8-openjdk" },
                  { name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk" },
                  { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
                  { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk" },
                  { name = "JavaSE-25", path = "/usr/lib/jvm/java-25-openjdk" },
                },
              },
            },
          },
          capabilities = capabilities,
          init_options = {
            bundles = get_bundles(),
            extendedClientCapabilities = extendedClientCapabilities,
          },
        }

        config.on_attach = function(client, bufnr)
          if jdtls.setup_dap then
            jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })
            require("jdtls.dap").setup_dap_main_class_configs()
          end
          local opts = { buffer = bufnr, silent = true, noremap = true }
          vim.keymap.set("n", "<leader>co", jdtls.organize_imports, { desc = "Organize Imports", buffer = bufnr })
          vim.keymap.set("n", "<leader>ct", jdtls.test_class, { desc = "Test Class", buffer = bufnr })
          vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, { desc = "Test Method", buffer = bufnr })
          vim.notify("JDTLS conectado!", vim.log.levels.INFO)
        end

        jdtls.start_or_attach(config)
      end

      start_jdtls()
    end,
  },
}
