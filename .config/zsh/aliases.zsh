# =============================================================================
# Aliases
# =============================================================================

# Adobe-specific
alias valutbb='export VAULT_ADDR="https://vault-amer.adobe.net" vault login -method=oidc -namespace=dx_blackbird'
alias klamdev="klam-ext ee-depencencies-dev"
alias klamprod="klam-ext ee-dependencies-prd"

# Kubernetes and Docker
alias kctx="kubectl config get-contexts -o name | fzf --height=20 | xargs kubectl config use-context"
alias kcd="kubectl config set-context --current --namespace"
alias dc="docker-compose"

# Git
alias g="git"
alias gallfiles="!f() { git log --name-only --diff-filter=A --pretty=format: | sort -u; }; f"
alias ga="g add -p"
alias gaa="g add --all"
alias gs="g status"
alias gi="g init"
alias gc="g commit"
alias gcm="g commit -m"
alias gl="g log --oneline"
alias gla="g log --oneline --graph --decorate --all"
alias gco="g checkout"
alias gcob="g checkout -b"

# General
alias ll="eza -l --icons --group-directories-first --time-style long-iso"
alias la="eza -la --icons --group-directories-first --time-style long-iso"
alias tree="ll --tree"
alias cat="bat"
alias vim="nvim"
alias vi="nvim"
alias v="nvim" 