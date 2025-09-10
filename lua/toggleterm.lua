local Terminal = require("toggleterm.terminal").Terminal

_G.test_term = Terminal:new({
  id = 13,
  direction = "horizontal",
  close_on_exit = false,
  hidden = true,
})

-- Register a global Lua function to toggle it
function _G.toggle_shared_test_term()
  test_term:toggle()
end

