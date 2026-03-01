# My Custom Keybindings

This repository contains my custom keybindings for my Neovim configuration. These keybindings enhance my productivity and make it easier for me to navigate and use Neovim efficiently.

![nvimIDE demo](./nvimIDE.gif)

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
- `<C-a>`: Select all.

### Telescope

- `<C-p>`: Opens the Telescope file finder.
- `<leader>fs`: Performs a live search using Telescope.
- `<leader>fh`: Displays help tags using Telescope.
- `<leader>fb`: Lists open buffers using Telescope.
- `<leader>ct`: Toggles the Tagbar sidebar.

**Search and Rename in Whole Project**.
  1. Press `<leader>fs` to initiate a live search using Telescope.
  2. Enter `StringOne` and press `Enter`.
  3. Use `Ctrl+q` to add search results to the quickfix list.
  4. Execute `:cdo s/StringOne/StringTwo/g | update` to replace all occurrences and save changes.

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
- `<leader>nc`: Renames the symbol under the cursor using the Language Server Protocol.
- `<leader>fr`: Uses Telescope to search for references to the symbol under the cursor. 

### Java

- `<leader>oi`: Organizes imports for the Java file.
- `<leader>jc`: Compiles the Java project incrementally.
- `<leader>tm`: Runs the test method under the cursor.
- `<leader>TM`: Runs the test method under the cursor with code coverage.
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

1. First, make sure to have Neovim installed on your system. You can install it using your package manager. For example, on a system with the `pkg` package manager, you can run:

    ```
    pkg update && pkg upgrade
    pkg install neovim git openjdk-17 gradle clang python nodejs ripgrep fd wget luarocks
    luarocks install tree-sitter-cli
    pip install pynvim --break-system-packages
    ```

2. Clone this repository into your Neovim configuration directory. Typically, this directory is located at `~/.config/nvim`. You can do this by running:

    ```
    git clone https://github.com/johnbunky/nvimTermuxJavaIDE.git ~/.config/nvim
    ```

3. Once cloned, navigate into the `~/.config/nvim` directory.

4. Run the following command to update plugins:

    ```
    nvim -c "MasonUpdate" -c "PackerInstall"
    ```

    During the installation process, you may be prompted to install additional components. Navigate and press 'i' for each component listed.

    :Mason
    - cucumber-language-server
    - gradle-language-server
    - groovy-language-server
    - java-debug-adapter
    - java-test
    - jdtls

5. If any issues arise during the setup process, you can check the health of Neovim by running:

    ```
    nvim -c "checkhealth"
    nvim -c "LspLog"
    ```

## Included Configuration Files

- `README.md`: This file providing setup instructions.
- `init.lua`: Neovim initialization file.
- `nvimIDE.gif`: A demonstration GIF.
- `ftplugin/groovy.lua` and `ftplugin/java.lua`: Configuration files for Groovy and Java filetype plugins.
- `lang-servers/intellij-java-google-style.xml`: Language server configuration for IntelliJ Java with Google Style.
- `lua/`: Lua configuration files including autopairs, colorscheme, completion, keymap, and others.
- `plugin/packer_compiled.lua`: Compiled plugin file for Packer.

## Inspiration Sources

Special thanks to the following sources for inspiration:

- [YouTube - Neovim Setup Tutorial Series](https://www.youtube.com/watch?v=jGAAnrOF2mQ&list=PLOb_fzsCdFtpf11TYmz0ND_fXwNtf3Lda&pp=iAQB)

- [YouTube - Neovim + LSP + Treesitter + Telescope](https://www.youtube.com/watch?v=w7i4amO_zaE&t=109s)

- [YouTube - Neovim Lua Setup](https://www.youtube.com/watch?v=vdn_pKJUda8&t=110s)
