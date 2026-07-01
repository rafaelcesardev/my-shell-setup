# ===========================================
# Zsh Shell Configuration
# Works on macOS, Linux and WSL (Homebrew everywhere)
# ===========================================

# --- Homebrew (macOS Apple Silicon / Intel, Linux / WSL) ---
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x "$HOME/.linuxbrew/bin/brew" ]; then
    eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi

# ===========================================
# History
# ===========================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE
setopt INTERACTIVE_COMMENTS              # allow '# comment' when pasting commands

# ===========================================
# Completion (needed for the autosuggest 'completion' strategy)
# ===========================================
fpath=("$HOMEBREW_PREFIX/share/zsh-completions" "$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
autoload -Uz compinit && compinit

# ===========================================
# fzf-tab (replaces the tab-completion menu with an fzf picker + preview)
# MUST load after compinit and before autosuggestions / syntax-highlighting
# ===========================================
source "$HOMEBREW_PREFIX/share/fzf-tab/fzf-tab.zsh"
zstyle ':completion:*' menu no                                   # let fzf-tab drive the menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons $realpath'  # dir preview on cd
zstyle ':fzf-tab:*' fzf-flags --height=60%                       # popup size

# ===========================================
# Autosuggestions (gray suggestion from history / completion)
# ===========================================
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ===========================================
# Prefix history search (Up/Down filters by what's already typed)
# ===========================================
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search    # Up
bindkey '^[[B' down-line-or-beginning-search  # Down
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search    # Up (terminfo fallback)
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search  # Down (terminfo fallback)

# ===========================================
# Interactive tools
# ===========================================
eval "$(starship init zsh)"          # prompt
eval "$(zoxide init zsh)"            # smart cd
cd() {                               # override: create the dir, then jump with zoxide
    [ -n "$1" ] && mkdir -p "$1"
    z "$@"
}

# FZF (fuzzy finder) - bat preview (the binary is 'bat' on every Homebrew platform)
export FZF_DEFAULT_OPTS="--style full --no-clear"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
source <(fzf --zsh)

# ===========================================
# WSL audio (WSLg PulseAudio) - no-op outside WSL
# ===========================================
[ -e /mnt/wslg/PulseServer ] && export PULSE_SERVER=/mnt/wslg/PulseServer

# ===========================================
# PATH
# ===========================================
# pnpm (home differs: ~/Library/pnpm on macOS, ~/.local/share/pnpm elsewhere)
if [ "$(uname)" = "Darwin" ]; then
    export PNPM_HOME="$HOME/Library/pnpm"
else
    export PNPM_HOME="$HOME/.local/share/pnpm"
fi
case ":$PATH:" in *":$PNPM_HOME:"*) ;; *) export PATH="$PNPM_HOME:$PATH" ;; esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"   # bun completions

# uv / local bin
export PATH="$HOME/.local/bin:$PATH"

# fnm (Node version manager; --use-on-cd switches version per folder)
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd)"

# ===========================================
# Aliases - System
# ===========================================
alias cls='clear'
alias mkdir='mkdir -pv'
alias ls='eza --color --long --git --no-filesize --icons --no-time --no-user --no-permissions'

# ===========================================
# Aliases - Homebrew
# ===========================================
alias i='brew install'
alias upd='brew update && brew upgrade'
alias clean='brew cleanup'

# ===========================================
# Aliases - Zsh Config
# ===========================================
alias f5='source ~/.zshrc'

# ===========================================
# Aliases - Docker
# ===========================================
alias d='docker'
alias dps='docker ps'
alias ds='docker stop'
alias di='docker images'
alias dv='docker volume'
alias dex='docker exec -it'

# Docker Compose
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcs='docker compose stop'
alias dcr='docker compose restart'
alias dcl='docker compose logs'
alias dcps='docker compose ps'
alias dcb='docker compose build'
alias dcp='docker compose pull'

# ===========================================
# Syntax highlighting
# MUST be the LAST line - paints the first word green (command exists)
# or red (command not found)
# ===========================================
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
