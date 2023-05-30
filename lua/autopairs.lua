local autopairs_setup, autopairs = pcall(require, 'nvim-autopairs')
if not autopairs_setup then
  vim.notify('autopairs is missing')
  return
end
autopairs.setup({
  ls_config = {
    lua = { enable = true },
  },  
})

-- need to add a lot form treesitter
