-- CMP Config
local cmp = require('cmp')
vim.o.shortmess = vim.o.shortmess .. "c"

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

cmp.setup {
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  end,
  snippet = { 
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  sources = {
      {name = 'nvim_lsp'}, 
      {name = 'buffer', keyword_length = 3},
      {name = "luasnip", keyword_length = 2},
  },

  window = {
    documentation = cmp.config.window.bordered()
  },

  completion = {completeopt = 'menu,menuone,noinsert'},
  preselect = cmp.PreselectMode.None,
  
  formatting = {

        format = require('lspkind').cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = { Codeium = "", }
        }) 
  },
  mapping = {
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
         -- behavior = cmp.ConfirmBehavior.Insert,
          select = false 
      }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
      ['<C-j>'] = function(fallback)
        if cmp.visible() then
          cmp.scroll_docs(4)
        else
          fallback()
        end
      end,
      ['<C-k>'] = function(fallback)
        if cmp.visible() then
          cmp.scroll_docs(-4)
        else
          fallback()
        end
      end,
      ['<C-Space>'] = cmp.mapping.complete(),
  },
}
