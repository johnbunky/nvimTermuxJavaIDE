local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

lspconfig.groovyls.setup {
  on_attach = function(client)
    print('Groovy language server started!')
    -- Additional configuration or setup for the language server
  end,
  cmd = { "java", "-jar", "/Users/you/.local/share/nvim/mason/packages/groovy-language-server/build/libs/groovy-language-server-all.jar"},
 
  root_dir = util.root_pattern('.git', '.groovy', 'build.gradle')
}
