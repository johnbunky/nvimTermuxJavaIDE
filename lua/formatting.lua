require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
