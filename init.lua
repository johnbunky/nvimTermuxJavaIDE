if vim.fn.has("win32") == 1 and vim.env.HOME == nil then
	vim.env.HOME = vim.env.USERPROFILE
end
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- Force Defold files to be treated as Lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.script", "*.gui_script", "*.render_script", "*.vp", "*.fp" },
	callback = function()
		vim.bo.filetype = "lua"
	end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.collection", "*.go", "*.gui", "*.input_binding", "*.project", "*.atlas" },
	callback = function()
		vim.bo.filetype = "defold"
	end,
})
vim.opt.encoding = "utf-8"
vim.opt.clipboard:append("unnamedplus")
vim.opt.timeoutlen = 1000

require("basic")
require("plugins")
require("colorscheme")
require("tree")
require("keymap")
require("autopairs")
require("completion")
require("toggleterm")
require("linting")
require("formatting")
require("bufferline").setup({
	options = {
		separator_style = "slant",
		diagnostics = "nvim_lsp",

		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true,
			},
		},
	},
})
require("lualine").setup({
	options = {
		theme = "gruvbox",
	},
})
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
					"go",
					"msg",
					"vmath",
					"factory",
					"sys",
					"sound",
					"particlefx",
					"camera",
					"collectionfactory",
					"collectionproxy",
					"physics",
					"resource",
					"image",
					"buffer",
					"json",
					"crash",
					"profiler",
					"render",
					"spine",
					"sprite",
					"tilemap",
					"label",
					"gui",
					"html5",
					"iap",
					"iac",
					"push",
					"webview",
					"window",
					"zlib",
					"http",
					"socket",
					"timer",
					"model",
					"facebook",
					-- Common Defold globals
					"hash",
					"pprint",
					"init",
					"final",
					"update",
					"on_message",
					"on_input",
					"on_reload",
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
					"lowercase-global", -- Defold uses lowercase module names
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
				callSnippet = "Replace",
			},
			hint = {
				enable = true,
				semicolon = "Disable",
			},
			codeLens = {
				enable = true,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
vim.lsp.enable("lua_ls")
-- Java
vim.lsp.config("jdtls", {
	cmd_env = {
		JAVA_HOME = "/usr/lib/jvm/java-21-openjdk",
	},
})
vim.lsp.enable("jdtls")

require("ibl").setup()
-- better Escape
require("better_escape").setup({
	timeout = vim.o.timeoutlen, -- after `timeout` passes, you can press the escape key and the plugin will ignore it
	default_mappings = false, -- setting this to false removes all the default mappings
	mappings = {
		-- i for insert
		i = {
			j = {
				j = "<Esc>",
			},
		},
		c = {
			j = {
				j = "<C-c>",
			},
		},
	},
})

-- TreeSettter Config
require("nvim-treesitter.install").compilers = { "clang" }
require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter").setup({
	ensure_installed = { "lua", "java" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})
