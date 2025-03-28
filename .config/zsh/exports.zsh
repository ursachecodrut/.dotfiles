# =============================================================================
# Environment Variables and Exports
# =============================================================================

# Editor and Terminal Settings
export EDITOR="nvim"
export TERM="xterm-256color"

# Path and Directory Settings
export FPATH="$HOME/.zsh/completions:$FPATH"
export MYVIMRC="$HOME/.config/nvim/init.lua"
export KUBECONFIG="$HOME/.kube/kubeconfig.yaml"
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/Library/pnpm"
export BUN_INSTALL="$HOME/.bun"
export WEZTERM_PATH="/Applications/WezTerm.app/Contents/MacOS"
export ADOBE_CONFIG_PATH="$HOME/.config/adobe/bin"
export LOCAL_BIN_PATH="$HOME/.local/bin"
export ASDF_DIR="$HOME/.asdf"
export SDKMAN_DIR="$HOME/.sdkman"

# PATH Configuration
export PATH="$LOCAL_BIN_PATH:$ADOBE_CONFIG_PATH:$PNPM_HOME:$BUN_INSTALL/bin:$WEZTERM_PATH:$ASDF_DIR/shims:$PATH"

# Language-specific Configurations
# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_BUILD_DOCS="yes"
export KERL_CONFIGURE_OPTIONS="--enable-dynamic-ssl-lib --enable-kernel-poll --enable-shared-zlib \
                               --enable-smp-support --enable-threads --enable-wx --with-wx-config=/opt/homebrew/bin/wx-config"

# External Tool Configurations
# klam-ext Integration
export KLAM_BROWSER="Google Chrome"
export KLAM_EXT_PROFILE_PREFIX="" 