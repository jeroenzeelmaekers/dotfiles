return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "saghen/blink.cmp",
  },
  config = function()
    local install_location = require("mason-core.installer.InstallLocation")
    local keymap = vim.keymap

    local function extend_bundles(bundles, paths, excluded)
      for _, path in ipairs(paths) do
        local name = vim.fn.fnamemodify(path, ":t")
        if not excluded[name] then
          bundles[#bundles + 1] = path
        end
      end
    end

    local function get_bundles()
      local share_dir = install_location.global():share()
      local bundles = {}

      extend_bundles(
        bundles,
        vim.fn.glob(share_dir .. "/java-debug-adapter/*.jar", true, true),
        {}
      )

      extend_bundles(
        bundles,
        vim.fn.glob(share_dir .. "/java-test/*.jar", true, true),
        {
          ["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true,
          ["jacocoagent.jar"] = true,
        }
      )

      return bundles
    end

    local function get_lombok_args(jdtls_path)
      local lombok_jar = jdtls_path .. "/lombok.jar"

      if vim.uv.fs_stat(lombok_jar) then
        return {
          "-javaagent:" .. lombok_jar,
          "-Xbootclasspath/a:" .. lombok_jar,
        }
      end

      return {}
    end

    local function start_jdtls(bufnr)
      local ok_registry, mason_registry = pcall(require, "mason-registry")
      if not ok_registry or not mason_registry.has_package("jdtls") or not mason_registry.is_installed("jdtls") then
        vim.notify("jdtls not installed. Run :MasonInstall jdtls", vim.log.levels.WARN)
        return
      end

      local root_dir = vim.fs.root(bufnr, {
        "gradlew",
        "mvnw",
        ".git",
        "pom.xml",
        "build.gradle",
        "build.gradle.kts",
        "settings.gradle",
        "settings.gradle.kts",
      }) or vim.fn.getcwd()

      local project_name = vim.fs.normalize(root_dir):gsub("[/\\:]", "_")
      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

      local jdtls_path = install_location.global():package("jdtls")
      local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar", true, true)[1]

      local config_dir_by_os = {
        Darwin = "config_mac",
        Linux = "config_linux",
        Windows_NT = "config_win",
      }
      local os_name = vim.uv.os_uname().sysname
      local config_dir_name = config_dir_by_os[os_name]

      if not launcher or not config_dir_name then
        vim.notify("jdtls install looks incomplete", vim.log.levels.ERROR)
        return
      end

      local jdtls = require("jdtls")
      local lombok_args = get_lombok_args(jdtls_path)
      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ERROR",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
        },
        root_dir = root_dir,
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        init_options = {
          bundles = get_bundles(),
        },
        on_attach = function(client, buffer)
          if client.name ~= "jdtls" then
            return
          end

          local function map(lhs, rhs, desc)
            keymap.set("n", lhs, rhs, { buffer = buffer, silent = true, desc = desc })
          end

          map("<leader>tc", jdtls.test_class, "Debug Java class")
          map("<leader>tm", jdtls.test_nearest_method, "Debug Java method")
          map("<leader>jo", jdtls.organize_imports, "Organize Java imports")

          vim.defer_fn(function()
            pcall(require("jdtls.dap").setup_dap_main_class_configs)
          end, 500)
        end,
        settings = {
          java = {
            signatureHelp = { enabled = true },
          },
        },
      }

      vim.list_extend(config.cmd, lombok_args)
      vim.list_extend(config.cmd, {
        "-jar",
        launcher,
        "-configuration",
        jdtls_path .. "/" .. config_dir_name,
        "-data",
        workspace_dir,
      })

      vim.api.nvim_buf_call(bufnr, function()
        jdtls.start_or_attach(config, {
          dap = {
            hotcodereplace = "auto",
          },
        })
      end)
    end

    local group = vim.api.nvim_create_augroup("JdtlsSetup", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "java",
      callback = function(args)
        start_jdtls(args.buf)
      end,
    })

    if vim.bo.filetype == "java" then
      start_jdtls(vim.api.nvim_get_current_buf())
    end
  end,
}
