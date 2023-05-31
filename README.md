# My Custom Keybindings

This repository contains my custom keybindings for my Neovim configuration. These keybindings enhance my productivity and make it easier for me to navigate and use Neovim efficiently.

## Keybindings

### General

- `<leader>h`: Clears the search highlighting.
- `<leader>ft`: Toggles the NvimTree file explorer.
- `<leader>ff`: Opens the NvimTree file explorer and initiates a file search.
- `<leader>qq`: Closes the current window.
- `<leader>ww`: Saves the current file.
- `<leader>wa`: Saves all open files.
- `<leader>to`: Opens a new tab.
- `<leader>tx`: Closes the current tab.
- `<leader>tn`: Switches to the next tab.
- `<leader>tp`: Switches to the previous tab.
- `<leader>sv`: Applies changes made to the current file.

### Telescope

- `<C-p>`: Opens the Telescope file finder.
- `<leader>fs`: Performs a live search using Telescope.
- `<leader>fh`: Displays help tags using Telescope.
- `<leader>fb`: Lists open buffers using Telescope.
- `<leader>ct`: Toggles the Tagbar sidebar.

### Auto Completion (cmp)

- `<C-e>`: Closes the completion menu.
- `<CR>`: Confirms the selected completion item.
- `<Tab>`: Selects the next completion item or performs the fallback action.
- `<S-Tab>`: Selects the previous completion item or performs the fallback action.
- `<C-j>`: Scrolls down in the completion menu.
- `<C-k>`: Scrolls up in the completion menu.
- `<C-Space>`: Triggers autocompletion.

### Terminal

- `<leader>t`: Toggles the terminal window.

### Bufferline

- `<leader>bq`: Deletes the current buffer.
- `<leader>bp`: Toggles pinning of the current buffer in the bufferline.
- `<leader>bs`: Prompts for a buffer to switch to using the bufferline.
- `<C-h>`: Cycles to the previous buffer using the bufferline.
- `<C-l>`: Cycles to the next buffer using the bufferline.

### LSP (Language Server Protocol)

- `<C-b>`: Jumps to the definition of the symbol under the cursor.
- `<C-k>`: Displays the signature help for the symbol under the cursor.
- `<S-R>`: Shows references to the symbol under the cursor.
- `<S-H>`: Displays hover information for the symbol under the cursor.
- `<A-Enter>`: Triggers code actions for the current line.

### Java

- `<leader>oi`: Organizes imports for the Java file.
- `<leader>jc`: Compiles the Java project incrementally.
- `<leader>tm`: Runs the test method under the cursor.
- `<leader>tc`: Runs all tests in the current class.
- `<leader>TC`: Runs all tests in the current class with code coverage.

### Debugging

- `gs`: Opens centered scopes in the debugging UI.
- `<leader>co`: Continues the debugging process.
- `<leader>so`: Steps over the next line.
- `<leader>si`: Steps into the next line.
- `<leader>ou`: Steps out of the current scope.
- `<leader>b`: Toggles a breakpoint at the current line.
- `<leader>B`: Sets a conditional breakpoint.
- `<leader>bl`: Sets a breakpoint with a log message.
- `<leader>dr`: Opens the debug REPL.
- `<leader>da`: Attaches to a running debug session
- 
## Installation

1. Install Neovim on your system.
2. Clone this repository into your Neovim configuration directory (usually located at `~/.config/nvim`).

