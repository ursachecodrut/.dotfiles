# =============================================================================
# Zsh Configuration File
# =============================================================================

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------
# Vim mode
# [!IMPORTANT]
# This must be set before sourcing fzf configuration so fzf ** tab completion
# works properly
bindkey -v

# -----------------------------------------------------------------------------
# Load Configuration Files
# -----------------------------------------------------------------------------
# Source all configuration files
for file in ~/.config/zsh/*.zsh; do
    source "$file"
done

# -----------------------------------------------------------------------------
# Conda Configuration
# -----------------------------------------------------------------------------
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/cursache/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/cursache/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/cursache/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/cursache/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
