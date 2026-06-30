-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"christoomey/vim-tmux-navigator",

	-- theme
	"ellisonleao/gruvbox.nvim",
	"rebelot/kanagawa.nvim",
	{ "mcchrish/zenbones.nvim", dependencies = { "rktjmp/lush.nvim" } },

	-- file explorer / icons
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",

	-- editing
	"numToStr/Comment.nvim",
	"windwp/nvim-autopairs",
	"max397574/better-escape.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"stevearc/conform.nvim",
	"mfussenegger/nvim-lint",

	-- UI
	"nvim-lualine/lualine.nvim",
	"akinsho/bufferline.nvim",
	"akinsho/toggleterm.nvim",

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- LSP (no Mason -- binaries come from system package manager)
	"neovim/nvim-lspconfig",
	"ray-x/lsp_signature.nvim",
	"onsails/lspkind.nvim",

	-- Java: extra refactor/test/debug support on top of jdtls LSP
	"mfussenegger/nvim-jdtls",

	-- snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",

	-- completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"octaltree/cmp-look",
			"hrsh7th/cmp-path",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-emoji",
		},
	},

	-- git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- debugging
	"mfussenegger/nvim-dap",
	"rcarriga/cmp-dap",
})
