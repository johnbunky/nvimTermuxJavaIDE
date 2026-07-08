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
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local map = function(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
					end

					-- navigation
					map("n", "]c", gs.next_hunk, "Next hunk")
					map("n", "[c", gs.prev_hunk, "Prev hunk")

					-- review
					map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
					map("n", "<leader>hd", gs.diffthis, "Diff this file")

					-- stage / reset
					map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
					map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
					map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
					map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
					map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

					-- visual mode stage/reset (selected lines only)
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, "Stage selected hunk")
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, "Reset selected hunk")

					-- blame
					map("n", "<leader>hb", gs.blame_line, "Blame line")
					map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle blame")
				end,
			})
		end,
	},

	-- debugging
	"mfussenegger/nvim-dap",
	"rcarriga/cmp-dap",
})
