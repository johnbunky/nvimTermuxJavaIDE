local P = {}
keymaps = P

-- leader --
vim.g.mapleader = ' '
-- key_mapping --
local key_map = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end
key_map('n', '<leader>h', ':nohlsearch<CR>') -- clear search
key_map('n', '<leader>ft', ':NvimTreeToggle<CR>') -- open tree
key_map('n', '<leader>ff', ':lua require"nvim-tree".find_file()<CR>') -- find file
key_map('n', '<leader>qq', ':q<CR>') -- close
key_map('n', '<leader>ww', ':w!<CR>') -- save
key_map('n', '<leader>wa', ':wa<CR>') -- save all
key_map('n', '<leader>to', ':tabnew<CR>') -- open new tab
key_map("n", "<leader>tx", ":tabclose<CR>") -- close current tab
key_map("n", "<leader>tn", ":tabn<CR>") --  go to next tab
key_map("n", "<leader>tp", ":tabp<CR>") --  go to previous tab
key_map('n', '<leader>sv', ':source %<CR>') -- apply changes
-- telescope
key_map('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_map('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_map('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_map('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
key_map('n', '<leader>ct', '<Cmd>TagbarToggle<CR>')
-- terminal
key_map('n', '<leader>t', ':lua toggle_shared_test_term()<CR>')
-- bufferline
key_map('n', '<leader>bq', '<Cmd>bdelete!<CR>')
key_map('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>')
key_map('n', '<leader>bs', '<Cmd>BufferLinePick<CR>')
key_map('n', '<C-h>', '<Cmd>BufferLineCyclePrev<CR>')
key_map('n', '<C-l>', '<Cmd>BufferLineCycleNext<CR>')

--LSP
-- function P.map_lsp_keys() 
  key_map('n', '<C-b>', ':lua vim.lsp.buf.definition()<CR>')
  key_map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
  key_map('n', '<S-R>', ':lua vim.lsp.buf.references()<CR>')
  key_map('n', '<S-H>', ':lua vim.lsp.buf.hover()<CR>')
  key_map('n', '<A-Enter>', ':lua vim.lsp.buf.code_action()<CR>')
  key_map('n', '<leader>nc', ':lua vim.lsp.buf.rename()<CR>')
  key_map('n', '<leader>fr', ':lua require"telescope.builtin".lsp_references()')
-- end

-- Java
function P.map_java_keys(bufnr)
  P.map_lsp_keys()
  key_map('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
  key_map('n', '<leader>jc', ':lua require("jdtls).compile("incremental")')
end

-- Debugging 
function debug_open_centered_scopes()
  local widgets = require'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end

key_map('n', 'gs', ':lua debug_open_centered_scopes()<CR>')
key_map('n', '<leader>co', ':lua require"dap".continue()<CR>')
key_map('n', '<leader>so', ':lua require"dap".step_over()<CR>')
key_map('n', '<leader>si', ':lua require"dap".step_into()<CR>')
key_map('n', '<leader>ou', ':lua require"dap".step_out()<CR>')
key_map('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
key_map('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
key_map('n', '<leader>bl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
key_map('n', '<leader>dr', ':lua require"dap".repl.open()<CR>')

-- run debug
function get_test_runner(test_name, debug)
  if debug then
    return 'dotnet test --filter "Category=playground&FullyQualifiedName~IntegrationsTestAutomation.Tests.' .. test_name .. '" --logger "console;verbosity=detailed"'
    -- return 'gradle test --tests="' .. test_name .. '" --debug-jvm' 
  end
    return 'dotnet test --filter "Category=playground&FullyQualifiedName~IntegrationsTestAutomation.Tests.' .. test_name .. '" --logger "console;verbosity=detailed"'
  -- return 'mvn test -Dtest="' .. test_name .. '"' 
end

function run_java_test_method(debug)
  local utils = require'utils'
  local method_name = utils.get_current_full_method_name("\\#")
  vim.cmd('term ' .. get_test_runner(method_name, debug))
end

function run_java_test_class(debug)
  local utils = require'utils'
  local class_name = utils.get_current_full_class_name()
  vim.cmd('term ' .. get_test_runner(class_name, debug))
end

local utils = require'utils'

local function run_test(name_getter, debug)
  local name = name_getter()
  if not name then
    print("Could not determine test name")
    return
  end

  local cmd = get_test_runner(name, debug)
  if not cmd then
    print("Command is nil. Check get_test_runner function.")
    return
  end

  if not _G.test_term then
    print("Shared terminal not initialized. Did you require your toggleterm config file?")
    return
  end

  -- _G.test_term:toggle()
  _G.test_term:send(cmd .. "\n", true)
end

-- Public API
function run_test_method(debug)
  run_test(function() return utils.get_current_full_method_name("\\#") end, debug)
end

function run_test_class(debug)
  run_test(utils.get_current_full_class_name, debug)
end

-- function get_spring_boot_runner(profile, debug)
--   local debug_param = ""
--   if debug then
--     debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
--   end 
--
--   local profile_param = ""
--   if profile then
--     profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
--   end
--
--   return 'mvn spring-boot:run ' .. profile_param .. debug_param
-- end
--
-- function run_spring_boot(debug)
--   vim.cmd('term ' .. get_spring_boot_runner("local", debug))
-- end

vim.keymap.set("n", "<leader>tm", function() run_test_method() end)
-- vim.keymap.set("n", "<leader>TM", function() run_java_test_method(true) end)
vim.keymap.set("n", "<leader>tc", function() run_test_class() end)
-- vim.keymap.set("n", "<leader>TC", function() run_java_test_class(true) end)
-- vim.keymap.set("n", "<F9>", function() run_spring_boot() end)
-- vim.keymap.set("n", "<F10>", function() run_spring_boot(true) end)

function attach_to_debug()
  local dap = require('dap')
  -- dap.adapters.java 
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
  dap.configurations.java = {
    {
      type = 'java';
      request = 'attach';
      name = "Attach to the process";
      hostName = 'localhost';
      port = '5005';
    },
  }
  dap.continue()
end 

key_map('n', '<leader>da', ':lua attach_to_debug()<CR>')

return P
