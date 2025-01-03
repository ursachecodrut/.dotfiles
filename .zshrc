# Zsh Configuration File

# Set Zsh and Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(asdf git zsh-syntax-highlighting zsh-autosuggestions kubectl)
source $ZSH/oh-my-zsh.sh

# Paths and Environment Variables
export FPATH="$HOME/.zsh/completions:$FPATH"
export MYVIMRC="$HOME/.config/nvim/init.lua"
export KUBECONFIG="$HOME/.kube/kubeconfig.yaml"
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/Library/pnpm"
export BUN_INSTALL="$HOME/.bun"
export BAT_THEME="Catppuccin Mocha"
export WEZTERM_PATH="/Applications/WezTerm.app/Contents/MacOS"
export PATH="$HOME/.local/bin:$PNPM_HOME:$BUN_INSTALL/bin:$WEZTERM_PATH:$PATH"

# Default Editor and Terminal
export EDITOR="nvim"
export TERM="xterm-256color"

# Load tools and completions
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
[ -s "/Users/cursache/.bun/_bun" ] && source "/Users/cursache/.bun/_bun"
. "/Users/cursache/.deno/env"

# Elixir Configurations
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_BUILD_DOCS="yes"
export KERL_CONFIGURE_OPTIONS="--enable-dynamic-ssl-lib --enable-kernel-poll --enable-shared-zlib \
                               --enable-smp-support --enable-threads --enable-wx --with-wx-config=/opt/homebrew/bin/wx-config"

# Adobe-specific Aliases
alias valutbb='export VAULT_ADDR="https://vault-amer.adobe.net" vault login -method=oidc -namespace=dx_blackbird'
alias klamdev="klam-ext ee-dep-dev"
alias klamprod="klam-ext ee-dep-prod"

# Kubernetes and Docker Aliases
alias kcd="kubectl config get-contexts -o name | fzf --height=20 | xargs kubectl config use-context"
alias dc="docker-compose"

# Git Aliases
alias ga="git add ."
alias gs="git status"
alias gi="git init"

# General Aliases
alias ll="eza -l --icons --group-directories-first --time-style long-iso"
alias la="eza -la --icons --group-directories-first --time-style long-iso"
alias tree="ll --tree"
alias cat="bat"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# fzf Configuration
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS=" \
   --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
   --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
   --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced fzf Key Bindings
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi' "$@" ;;
  esac
}

# Starship Prompt
eval "$(starship init zsh)"

# SDKMAN Initialization
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# klam-ext Integration
export KLAM_PYTHON="/opt/homebrew/bin/python3"
export KLAM_BROWSER="Arc"
export KLAM_EXT_PROFILE_PREFIX=""
if command -v klam-ext &> /dev/null; then
    eval "$(env klam-ext zsh-integration)";
fi

# Yazi auto cd to directory
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Zoxide Initialization with cd as default command
eval "$(zoxide init --cmd cd zsh)"
