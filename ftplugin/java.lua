local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "nvim-jdtls not found"
  return
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
vim.fn.mkdir(workspace_dir, "p")

-- locate jdtls install dir from the binary itself, no hardcoded OS path
local jdtls_bin = vim.fn.exepath("jdtls")
if jdtls_bin == "" then
  vim.notify "jdtls binary not found in PATH"
  return
end

-- the system jdtls launcher script handles JVM args/jar/config internally,
-- so we just call it directly instead of hand-building the java invocation
local config = {
  cmd_env = {
    JAVA_HOME = "/usr/lib/jvm/java-21-openjdk", -- Arch path; override per-machine if needed
  },
  cmd = { jdtls_bin, "-data", workspace_dir },

  root_dir = root_dir,

  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = { "java", "javax", "com", "org" },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  -- debug adapter bundle: only wired up if java-debug is actually present;
  -- otherwise jdtls still starts fine without debug support
  init_options = {
    bundles = (function()
      local debug_jar = vim.fn.glob(
        vim.fn.stdpath("data") .. "/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar"
      )
      if debug_jar ~= "" then
        return { debug_jar }
      end
      return {}
    end)(),
  },
}

config.on_attach = function(client, bufnr)
  local ok_keymaps, keymaps = pcall(require, "keymaps")
  if ok_keymaps then
    keymaps.map_java_keys(bufnr)
  end

  local ok_sig, lsp_signature = pcall(require, "lsp_signature")
  if ok_sig then
    lsp_signature.on_attach({
      bind = true,
      floating_window_above_cur_line = false,
      padding = "",
      handler_opts = { border = "rounded" },
    }, bufnr)
  end
end

require("jdtls").start_or_attach(config)
