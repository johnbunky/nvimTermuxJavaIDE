-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- use 'nvim-lua/plenary.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'lewis6991/impatient.nvim'
  -- themes
  use 'ellisonleao/gruvbox.nvim'
  -- file explorer
  use 'nvim-tree/nvim-tree.lua'
  -- vs-code like icons
  use 'nvim-tree/nvim-web-devicons'
  -- commenting with gc
  use 'numToStr/Comment.nvim' 
  -- statusline
  use 'nvim-lualine/lualine.nvim'
  -- bufferline
  use 'akinsho/bufferline.nvim'
  -- autopair
  use 'windwp/nvim-autopairs'
  -- telescope
  use {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- languages parser and highlight 
  use 'sheerun/vim-polyglot'
  use 'nvim-treesitter/nvim-treesitter'
  -- mason
  use "williamboman/mason.nvim"
  use 'williamboman/mason-lspconfig.nvim'
  -- use 'jay-babu/mason-null-ls.nvim'
  -- managing & installing lsp servers, linters & formatters
  use 'neovim/nvim-lspconfig'
  -- use 'kabouzeid/nvim-lspinstall'
  use 'mfussenegger/nvim-jdtls'
  use "ray-x/lsp_signature.nvim"
  -- coc
  -- use {'neoclide/coc.nvim', branch = 'release'}
  -- terminal
  use 'akinsho/toggleterm.nvim'
  -- some useful stuff
  use 'onsails/lspkind.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use 'max397574/better-escape.nvim'
  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  -- autocompletion
  -- use {'ms-jpq/coq_nvim', branch = 'coq'}
  -- use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", 
      "hrsh7th/cmp-nvim-lsp",
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'octaltree/cmp-look', 
      'hrsh7th/cmp-path', 
      'f3fora/cmp-spell', 
      'hrsh7th/cmp-emoji'
    }
  }  
  -- git sign
  use {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
  end}
  -- Debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/cmp-dap'
  -- AIs
  use 'madox2/vim-ai' -- asks money
  -- use 'Exafunction/codeium.vim' -- doesn't work on android, yet 
  use { "zbirenbaum/copilot.lua" } -- asks money
--   use {
--   "zbirenbaum/copilot-cmp",
--   after = { "copilot.lua" },
--   config = function ()
--     require("copilot_cmp").setup()
--   end
-- }
-- use {                           -- doesn't work on android
--   'tzachar/cmp-tabnine',
--   run = './install.sh',
--   requires = 'hrsh7th/nvim-cmp'
-- } 
end)
