# =============================================================================
# Plugin Configurations
# =============================================================================

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions kubectl)
source $ZSH/oh-my-zsh.sh

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Bun
[ -s "/Users/cursache/.bun/_bun" ] && source "/Users/cursache/.bun/_bun"

# Deno
. "/Users/cursache/.deno/env"

# SDKMAN
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Starship Prompt
eval "$(starship init zsh)"

# klam-ext Integration
if command -v klam-ext &> /dev/null; then
    eval "$(env klam-ext zsh-integration)";
fi

# GHCup
[ -f "/Users/cursache/.ghcup/env" ] && . "/Users/cursache/.ghcup/env" 