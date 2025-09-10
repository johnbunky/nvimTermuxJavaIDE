vim.opt.encoding = 'utf-8'
vim.opt.clipboard:append("unnamedplus")
vim.opt.timeoutlen = 1000

require 'basic'
require 'plug_packer'
require 'colorscheme'
require 'tree'
require 'keymap'
require 'autopairs'
require 'completion'
require'toggleterm'
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
    ensure_installed = { "gradle_ls", "jdtls",},
}
require'lspconfig' 
require'lspconfig'.gradle_ls.setup{}
require'lspconfig'.groovyls.setup{}
require'lspconfig'.cucumber_language_server.setup{
    cmd = { "cucumber-language-server", "--stdio" },
    filetypes = { "cucumber", "feature" },
    root_dir = require("lspconfig").util.find_git_ancestor,
    settings = {
        features= {'src/test/**/*.feature'},
        glue = {'src/test/**/*.java'}
    }
}
require'lspconfig'.pyright.setup{}
require('ibl').setup()
require'lspconfig'.csharp_ls.setup{}
-- better Escape
require("better_escape").setup {
    mapping = {"jk", "jj"}, -- a table with mappings to use
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
})
