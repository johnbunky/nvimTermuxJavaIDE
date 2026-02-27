if vim.fn.has("win32") == 1 and vim.env.HOME == nil then
  vim.env.HOME = vim.env.USERPROFILE
end
-- Force Defold files to be treated as Lua
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.script", "*.gui_script", "*.render_script", "*.vp", "*.fp"},
  callback = function()
    vim.bo.filetype = "lua"
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.collection", "*.go", "*.gui", "*.input_binding" },
  callback = function()
    vim.bo.filetype = "defold"
  end,
})
vim.opt.encoding = 'utf-8'
vim.opt.clipboard:append("unnamedplus")
vim.opt.timeoutlen = 1000
vim.g.python3_host_prog = "C:/Users/jko/scoop/apps/python/current/python.exe"

require 'basic'
require 'plug_packer'
require 'colorscheme'
require 'tree'
require 'keymap'
require 'autopairs'
require 'completion'
require 'toggleterm'
require("bufferline").setup{
  options = {
    separator_style = "slant",
    diagnostics = "nvim_lsp",
  
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      }
    }
  }
}
require('lualine').setup {
  options = {
    theme = 'gruvbox'
  }
}
require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = { "gradle_ls", "jdtls", "lua_ls"},
}
-- Lua LSP config
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "Lua 5.1", -- Defold uses LuaJIT (5.1 compatible)
      },
      diagnostics = {
        globals = {
          "vim",
          -- Core Defold modules
          "go", "msg", "vmath", "factory", "sys", "sound", 
          "particlefx", "camera", "collectionfactory", "collectionproxy",
          "physics", "resource", "image", "buffer", "json", 
          "crash", "profiler", "render", "spine", "sprite", 
          "tilemap", "label", "gui", "html5", "iap", "iac",
          "push", "webview", "window", "zlib", "http",
          "socket", "timer", "model", "facebook",
          -- Common Defold globals
          "hash", "pprint", "init", "final", "update", 
          "on_message", "on_input", "on_reload",
          -- DefOS extension
          "defos",  
           -- Monarch screen manager
          "monarch",    
           -- Rendercam
          "rendercam",    
          -- Druid UI
          "druid",    
          -- Nakama
          "nakama",
        },
        disable = {
          "lowercase-global",  -- Defold uses lowercase module names
          "trailing-space",
        },
        -- Group diagnostics by severity
        groupSeverity = {
          strong = "Warning",
          strict = "Information",
        },
      },
      workspace = {
        checkThirdParty = false,
        -- Don't index Defold build directories
        ignoreDir = {
          ".git",
          "build",
          ".internal",
        },
        -- Remove the library setting entirely for Defold projects
        -- or keep it empty
        library = {},
      },
      completion = {
        callSnippet = "Replace"
      },
      hint = {
        enable = true,
        semicolon = "Disable"
      },
      codeLens = {
        enable = true
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable("lua_ls")
-- Gradle
vim.lsp.config("gradle_ls", {})

-- Groovy
vim.lsp.config("groovyls", {})

-- Cucumber
vim.lsp.config("cucumber_language_server", {
    cmd = { "cucumber-language-server", "--stdio" },
    filetypes = { "cucumber", "feature" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
    settings = {
        features = { "src/test/**/*.feature" },
        glue = { "src/test/**/*.java" },
    },
})

-- Python
vim.lsp.enable("pyright")

-- C#
vim.lsp.enable("csharp_ls")
require('ibl').setup()
-- better Escape
require("better_escape").setup {
    timeout = vim.o.timeoutlen, -- after `timeout` passes, you can press the escape key and the plugin will ignore it
    default_mappings = true, -- setting this to false removes all the default mappings
    mappings = {
        -- i for insert
        i = {
            j = {
                -- These can all also be functions
                k = "<Esc>",
                j = "<Esc>",
            },
        },
        c = {
            j = {
                k = "<C-c>",
                j = "<C-c>",
            },
        },
        t = {
            j = {
                k = "<C-\\><C-n>",
            },
        },
        v = {
            j = {
                k = "<Esc>",
            },
        },
        s = {
            j = {
                k = "<Esc>",
            },
        },
    },
}

-- TreeSettter Config
local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = {"lua", "java", "groovy"},
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true }
}
-- AIs 
-- require("copilot").setup{}
-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({max_lines = 1000, max_num_results = 20, sort = true})
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
  ignore_certificate_errors = false,
  -- workspace_folders = {
  --   paths = { "/your/project" },
  --   get_paths = function()
  --       return { "/your/project" }
  --   end,
  -- },
})
