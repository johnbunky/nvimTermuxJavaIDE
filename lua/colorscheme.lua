vim.cmd("colorscheme gruvbox")
require("kanagawa").setup({
	transparent = true,
	theme = "dragon",
	background = { dark = "dragon" },
})

vim.cmd("colorscheme kanagawa-dragon")

-- ensure transparency carries through to floats and inactive windows
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
