# nvim config

Minimal, portable Neovim setup following the Unix philosophy:
**Neovim is the frontend. The OS manages the toolchain.**

![nvimIDE demo](./nvimIDE.gif)

## Philosophy

Two schools of thought exist for Neovim setups:

**"Neovim manages everything"** — Mason, LazyVim, Copilot, DAP, Node runtimes downloaded inside `~/.local/share/nvim`. Convenient, IDE-like, heavy.

**"Unix manages everything"** — `pacman`, `pkg`, `apt`, `brew`. Neovim talks to whatever binaries are already in PATH. Small programs, one responsibility, composable.

This config follows the second approach.

## Stack

```
Neovim
├── lazy.nvim          plugin manager
├── builtin LSP        vim.lsp.config / vim.lsp.enable (no lspconfig layer needed)
├── nvim-treesitter    highlighting, indentation, text objects
├── telescope.nvim     fuzzy finder (requires ripgrep + fd)
├── nvim-cmp           completion (pure Lua, no native compile)
├── conform.nvim       formatting (delegates to system binaries)
├── nvim-lint          linting (delegates to system binaries)
├── nvim-jdtls         Java: debug, test runner, refactors (on top of jdtls LSP)
└── gitsigns.nvim      git decorations

System packages (installed via pacman / pkg / apt / brew)
├── lua-language-server
├── jdtls              (AUR on Arch; requires JDK21+)
├── shellcheck
├── shfmt
├── stylua
├── ripgrep
├── fd
└── git
```

No Node. No Python. No Mason.

## Installation

### 1. Install system dependencies

**Arch Linux:**
```bash
sudo pacman -S --needed lua-language-server shellcheck shfmt stylua ripgrep fd git
yay -S jdtls
```

> `jdtls` requires JDK21+. Keep your system default JDK at 17 if you build
> love-android/Gradle projects — jdtls is pinned to JDK21 via `JAVA_HOME`
> in `ftplugin/java.lua`, independent of your system default.
>
> Install JDK21 alongside your existing JDK:
> ```bash
> sudo pacman -S jdk21-openjdk
> # do NOT run archlinux-java set -- leave system default as-is
> ```

**Termux:**
```bash
pkg install lua-language-server shellcheck shfmt stylua ripgrep fd git neovim
# jdtls not available on Termux -- Java LSP skipped on Android
```

**Debian/Ubuntu:**
```bash
sudo apt install lua-language-server shellcheck shfmt ripgrep fd-find git
# stylua: grab binary from https://github.com/JohnnyMorganz/StyLua/releases
# jdtls: grab from https://github.com/eclipse-jdtls/eclipse.jdt.ls/releases
```

### 2. Install a Nerd Font

Required for icons in NvimTree, bufferline, and lualine.
Download from [nerdfonts.com](https://www.nerdfonts.com/) and set as your terminal font.

### 3. Clone the config

```bash
git clone -b minimal https://github.com/johnbunky/nvimTermuxJavaIDE.git ~/.config/nvim
```

### 4. First launch

Open Neovim — lazy.nvim bootstraps itself and installs all plugins automatically.
Watch the progress with `:Lazy`. No `:PackerSync`, no `:MasonUpdate` needed.

### 5. Verify

```vim
:checkhealth
```

## Keybindings

### General
| Key | Action |
|-----|--------|
| `<leader>h` | Clear search highlight |
| `<leader>ft` | Toggle NvimTree |
| `<leader>ff` | Open NvimTree + file search |
| `<leader>qq` | Close window |
| `<leader>ww` | Save file |
| `<leader>wa` | Save all files |
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<C-a>` | Select all |

### Telescope
| Key | Action |
|-----|--------|
| `<C-p>` | File finder |
| `<leader>fs` | Live grep |
| `<leader>fh` | Help tags |
| `<leader>fb` | Open buffers |

**Project-wide search and replace:**
1. `<leader>fs` → enter search term → `<Enter>`
2. `Ctrl+q` → send results to quickfix list
3. `:cdo s/OldString/NewString/g | update`

### Completion (nvim-cmp)
| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<Tab>` | Next item |
| `<S-Tab>` | Previous item |
| `<C-j>` | Scroll docs down |
| `<C-k>` | Scroll docs up |
| `<C-e>` | Close menu |

### Bufferline
| Key | Action |
|-----|--------|
| `<C-h>` | Previous buffer |
| `<C-l>` | Next buffer |
| `<leader>bq` | Delete buffer |
| `<leader>bp` | Pin buffer |
| `<leader>bs` | Switch buffer |

### Terminal
| Key | Action |
|-----|--------|
| `<leader>t` | Toggle terminal |

### LSP
| Key | Action |
|-----|--------|
| `<C-b>` | Go to definition |
| `<S-H>` | Hover info |
| `<S-R>` | References |
| `<A-Enter>` | Code actions |
| `<leader>nc` | Rename symbol |
| `<leader>fr` | Telescope references |

### Java (nvim-jdtls)
| Key | Action |
|-----|--------|
| `<leader>oi` | Organize imports |
| `<leader>jc` | Incremental compile |
| `<leader>tm` | Run test method |
| `<leader>TM` | Run test method (coverage) |
| `<leader>tc` | Run test class |
| `<leader>TC` | Run test class (coverage) |

### Debugging (nvim-dap)
| Key | Action |
|-----|--------|
| `<leader>co` | Continue |
| `<leader>so` | Step over |
| `<leader>si` | Step into |
| `<leader>ou` | Step out |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Conditional breakpoint |
| `<leader>bl` | Log breakpoint |
| `<leader>dr` | Debug REPL |
| `<leader>da` | Attach to session |

## File Structure

```
~/.config/nvim/
├── init.lua                          entry point
├── lazy-lock.json                    pinned plugin versions (committed)
├── lang-servers/
│   └── intellij-java-google-style.xml
├── ftplugin/
│   └── java.lua                      jdtls start_or_attach + debug wiring
└── lua/
    ├── basic.lua                     core options
    ├── plugins.lua                   lazy.nvim spec
    ├── colorscheme.lua
    ├── keymap.lua
    ├── completion.lua                nvim-cmp config
    ├── linting.lua                   nvim-lint (shellcheck)
    ├── formatting.lua                conform.nvim (stylua, shfmt)
    ├── tree.lua                      nvim-tree config
    ├── autopairs.lua
    └── toggleterm.lua
```

## Compatibility

| Environment | Status | Notes |
|-------------|--------|-------|
| Arch Linux | ✅ | Full stack including jdtls/Java |
| Termux (Android) | ✅ | lua_ls + shell tools; jdtls skipped |
| iSH (iOS) | 🔄 | Treesitter compile slow on x86 emu |
| Windows | ⚠️ | Untested on this branch |
