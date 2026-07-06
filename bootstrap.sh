#!/usr/bin/env bash
# bootstrap.sh — nvim toolchain installer
# Unix manages everything. Edit the list below, run once per machine.
# Re-run anytime to add new servers or update existing ones.
#
# Usage:
#   chmod +x bootstrap.sh
#   ./bootstrap.sh

set -e

# ─────────────────────────────────────────────
# EDIT THIS LIST to enable/disable language servers and tools
# ─────────────────────────────────────────────

LSP_LUA=true  # lua-language-server
LSP_JAVA=true # jdtls (Java)
TOOL_SHELLCHECK=true
TOOL_SHFMT=true
TOOL_STYLUA=true
TOOL_RIPGREP=true
TOOL_FD=true

# ─────────────────────────────────────────────
# DO NOT EDIT BELOW THIS LINE
# ─────────────────────────────────────────────

JDTLS_VERSION="1.60.0"
JDTLS_TIMESTAMP="202506271355" # update when bumping version
JDTLS_DIR="$HOME/.local/share/jdtls"

# ── detect OS ────────────────────────────────

OS=""
PKG=""

if [ -f /etc/arch-release ]; then
  OS="arch"
  PKG="pacman"
elif [ "$(uname -o)" = "Android" ]; then
  OS="termux"
  PKG="pkg"
elif [ -f /etc/alpine-release ]; then
  OS="alpine" # iSH
  PKG="apk"
elif [ -f /etc/debian_version ]; then
  OS="debian"
  PKG="apt"
elif command -v brew &>/dev/null; then
  OS="macos"
  PKG="brew"
else
  echo "ERROR: unsupported OS"
  exit 1
fi

echo "==> detected: $OS ($PKG)"

# ── helpers ───────────────────────────────────

install_pkg() {
  case "$PKG" in
  pacman) sudo pacman -S --needed --noconfirm "$@" ;;
  pkg) pkg install -y "$@" ;;
  apk) apk add --no-cache "$@" ;;
  apt) sudo apt install -y "$@" ;;
  brew) brew install "$@" ;;
  esac
}

have() { command -v "$1" &>/dev/null; }

# ── C compiler (required for treesitter) ─────

echo "==> checking C compiler"
if ! have gcc && ! have clang; then
  case "$OS" in
  arch) install_pkg base-devel ;;
  termux) install_pkg clang ;;
  alpine) install_pkg gcc musl-dev ;;
  debian) install_pkg build-essential ;;
  macos) xcode-select --install 2>/dev/null || true ;;
  esac
fi

# ── git ───────────────────────────────────────

have git || install_pkg git

# ── JDK21 (required for jdtls) ───────────────

if [ "$LSP_JAVA" = "true" ]; then
  echo "==> checking JDK21"
  case "$OS" in
  arch)
    # keep system default untouched (may be JDK17 for Gradle/love-android)
    if [ ! -d /usr/lib/jvm/java-21-openjdk ]; then
      install_pkg jdk21-openjdk
    fi
    ;;
  termux)
    have java || install_pkg openjdk-21
    ;;
  alpine)
    have java || apk add openjdk21
    ;;
  debian)
    have java || sudo apt install -y openjdk-21-jdk
    ;;
  macos)
    have java || brew install openjdk@21
    ;;
  esac
fi

# ── lua-language-server ───────────────────────

if [ "$LSP_LUA" = "true" ]; then
  echo "==> lua-language-server"
  if ! have lua-language-server; then
    case "$OS" in
    arch) install_pkg lua-language-server ;;
    termux) install_pkg lua-language-server ;;
    alpine) apk add lua-language-server ;;
    debian)
      echo "  lua-language-server not in apt — downloading binary"
      _LLS_VER="3.13.5"
      _LLS_URL="https://github.com/LuaLS/lua-language-server/releases/download/${_LLS_VER}/lua-language-server-${_LLS_VER}-linux-x64.tar.gz"
      mkdir -p "$HOME/.local/share/lua-language-server"
      curl -L "$_LLS_URL" | tar -xz -C "$HOME/.local/share/lua-language-server"
      ln -sf "$HOME/.local/share/lua-language-server/bin/lua-language-server" \
        "$HOME/.local/bin/lua-language-server"
      ;;
    macos) install_pkg lua-language-server ;;
    esac
  else
    echo "  already installed: $(which lua-language-server)"
  fi
fi

# ── jdtls ─────────────────────────────────────

if [ "$LSP_JAVA" = "true" ]; then
  echo "==> jdtls"
  case "$OS" in
  arch)
    # AUR — requires yay
    if ! have jdtls; then
      if have yay; then
        yay -S --noconfirm jdtls
      else
        echo "  ERROR: yay not found. Install yay first, then re-run."
        echo "    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
        exit 1
      fi
    else
      echo "  already installed: $(which jdtls)"
    fi
    ;;
  termux | alpine | debian | macos)
    # direct jar download from GitHub releases
    if [ ! -f "$JDTLS_DIR/plugins/org.eclipse.equinox.launcher_"*.jar ] 2>/dev/null; then
      echo "  downloading jdtls ${JDTLS_VERSION}"
      mkdir -p "$JDTLS_DIR"
      _URL="https://download.eclipse.org/jdtls/milestones/${JDTLS_VERSION}/jdt-language-server-${JDTLS_VERSION}-${JDTLS_TIMESTAMP}.tar.gz"
      curl -L "$_URL" | tar -xz -C "$JDTLS_DIR"

      # write a launcher script so 'jdtls' works from PATH
      mkdir -p "$HOME/.local/bin"
      cat >"$HOME/.local/bin/jdtls" <<'LAUNCHER'
#!/usr/bin/env bash
JAR=$(ls "$HOME/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_"*.jar 2>/dev/null | head -1)
CONFIG="$HOME/.local/share/jdtls/config_linux"
[ "$(uname)" = "Darwin" ] && CONFIG="$HOME/.local/share/jdtls/config_mac"
exec java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED \
  -jar "$JAR" \
  -configuration "$CONFIG" \
  "$@"
LAUNCHER
      chmod +x "$HOME/.local/bin/jdtls"
      echo "  installed to $JDTLS_DIR"
      echo "  launcher: $HOME/.local/bin/jdtls"
      echo "  ensure $HOME/.local/bin is in your PATH"
    else
      echo "  already installed: $JDTLS_DIR"
    fi
    ;;
  esac
fi

# ── shellcheck ────────────────────────────────

if [ "$TOOL_SHELLCHECK" = "true" ]; then
  echo "==> shellcheck"
  if ! have shellcheck; then
    case "$OS" in
    arch) install_pkg shellcheck ;;
    termux) install_pkg shellcheck ;;
    alpine) apk add shellcheck ;;
    debian) install_pkg shellcheck ;;
    macos) install_pkg shellcheck ;;
    esac
  else
    echo "  already installed: $(which shellcheck)"
  fi
fi

# ── shfmt ─────────────────────────────────────

if [ "$TOOL_SHFMT" = "true" ]; then
  echo "==> shfmt"
  if ! have shfmt; then
    case "$OS" in
    arch) install_pkg shfmt ;;
    termux) install_pkg shfmt ;;
    alpine) apk add shfmt ;;
    debian)
      # not in apt — download binary
      _SHFMT_VER="3.8.0"
      curl -L "https://github.com/mvdan/sh/releases/download/v${_SHFMT_VER}/shfmt_v${_SHFMT_VER}_linux_amd64" \
        -o "$HOME/.local/bin/shfmt"
      chmod +x "$HOME/.local/bin/shfmt"
      ;;
    macos) install_pkg shfmt ;;
    esac
  else
    echo "  already installed: $(which shfmt)"
  fi
fi

# ── stylua ────────────────────────────────────

if [ "$TOOL_STYLUA" = "true" ]; then
  echo "==> stylua"
  if ! have stylua; then
    case "$OS" in
    arch) install_pkg stylua ;;
    termux) install_pkg stylua ;;
    alpine | debian)
      _STYLUA_VER="2.0.2"
      _ARCH="x86_64"
      [ "$(uname -m)" = "aarch64" ] && _ARCH="aarch64"
      curl -L "https://github.com/JohnnyMorganz/StyLua/releases/download/v${_STYLUA_VER}/stylua-linux-${_ARCH}.zip" \
        -o /tmp/stylua.zip
      unzip -o /tmp/stylua.zip -d "$HOME/.local/bin"
      chmod +x "$HOME/.local/bin/stylua"
      rm /tmp/stylua.zip
      ;;
    macos) install_pkg stylua ;;
    esac
  else
    echo "  already installed: $(which stylua)"
  fi
fi

# ── ripgrep ───────────────────────────────────

if [ "$TOOL_RIPGREP" = "true" ]; then
  echo "==> ripgrep"
  have rg || install_pkg ripgrep
fi

# ── fd ────────────────────────────────────────

if [ "$TOOL_FD" = "true" ]; then
  echo "==> fd"
  if ! have fd && ! have fdfind; then
    case "$OS" in
    debian) install_pkg fd-find ;;
    *) install_pkg fd ;;
    esac
  fi
fi

# ── done ──────────────────────────────────────

echo ""
echo "==> done. verify with:"
echo "    nvim --headless -c 'checkhealth' -c 'qa' 2>&1 | grep -E 'OK|ERROR|WARNING'"
